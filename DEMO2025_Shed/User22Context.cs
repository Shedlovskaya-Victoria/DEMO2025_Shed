using System;
using System.Collections.Generic;
using DEMO2025_Shed.ModelBD;
using Microsoft.EntityFrameworkCore;

namespace DEMO2025_Shed;

public partial class User22Context : DbContext
{
    public User22Context()
    {
    } 

    public User22Context(DbContextOptions<User22Context> options)
        : base(options)
    {
    }

    public virtual DbSet<AdditionalProduct> AdditionalProducts { get; set; }

    public virtual DbSet<AdditionalProductClientsCross> AdditionalProductClientsCrosses { get; set; }

    public virtual DbSet<AllUser> AllUsers { get; set; }

    public virtual DbSet<CategoriesRoom> CategoriesRooms { get; set; }

    public virtual DbSet<Reservation> Reservations { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<RoomsFond> RoomsFonds { get; set; }

    public virtual DbSet<RoomsStatus> RoomsStatuses { get; set; }

    public virtual DbSet<SheduleCleaning> SheduleCleanings { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("server=192.168.200.35;database=user22;user=user22;password=37354;TrustServerCertificate=true");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AdditionalProduct>(entity =>
        {
            entity.ToTable("AdditionalProduct");

            entity.Property(e => e.Cost).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Description).HasMaxLength(200);
            entity.Property(e => e.Title).HasMaxLength(50);
        });

        modelBuilder.Entity<AdditionalProductClientsCross>(entity =>
        {
            entity.HasKey(e => e.CrossId);

            entity.ToTable("AdditionalProductClientsCross");

            entity.HasOne(d => d.AdditionalProduct).WithMany(p => p.AdditionalProductClientsCrosses)
                .HasForeignKey(d => d.AdditionalProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AdditionalProductClientsCross_AdditionalProduct");

            entity.HasOne(d => d.User).WithMany(p => p.AdditionalProductClientsCrosses)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AdditionalProductClientsCross_Users");
        });

        modelBuilder.Entity<AllUser>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("AllUsers");

            entity.Property(e => e.Fio)
                .HasMaxLength(150)
                .IsUnicode(false)
                .HasColumnName("FIO");
            entity.Property(e => e.Login)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Password)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UserId).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<CategoriesRoom>(entity =>
        {
            entity.HasKey(e => e.CategoryId);

            entity.Property(e => e.Title).HasMaxLength(80);
        });

        modelBuilder.Entity<Reservation>(entity =>
        {
            entity.HasKey(e => e.ReservId);

            entity.Property(e => e.Comments).HasMaxLength(200);
            entity.Property(e => e.CostRoom).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Discount).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Usert).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.UsertId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Reservations_Users");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.Property(e => e.Title).HasMaxLength(50);
        });

        modelBuilder.Entity<RoomsFond>(entity =>
        {
            entity.ToTable("RoomsFond");

            entity.Property(e => e.RoomsFondId).HasColumnName("RoomsFond\rId");
            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.CategoryRoom).WithMany(p => p.RoomsFonds)
                .HasForeignKey(d => d.CategoryRoomId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RoomsFond_CategoriesRooms");

            entity.HasOne(d => d.RoomStatus).WithMany(p => p.RoomsFonds)
                .HasForeignKey(d => d.RoomStatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RoomsFond_RoomsStatuses");
        });

        modelBuilder.Entity<RoomsStatus>(entity =>
        {
            entity.HasKey(e => e.StatusId);

            entity.Property(e => e.Title).HasMaxLength(50);
        });

        modelBuilder.Entity<SheduleCleaning>(entity =>
        {
            entity.HasKey(e => e.CleanId);

            entity.ToTable("SheduleCleaning");

            entity.Property(e => e.DateTimeEnd).HasColumnType("datetime");
            entity.Property(e => e.DateTimeStart).HasColumnType("datetime");

            entity.HasOne(d => d.User).WithMany(p => p.SheduleCleanings)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_SheduleCleaning_Users");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.Property(e => e.Fio)
                .HasMaxLength(150)
                .HasColumnName("FIO");
            entity.Property(e => e.Login).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(50);

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Users_Roles");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
