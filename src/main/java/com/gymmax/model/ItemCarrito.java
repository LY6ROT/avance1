package com.gymmax.model;

public class ItemCarrito {
    private Plan plan;
    private int cantidad;
    private double subtotal;

    public ItemCarrito(Plan plan, int cantidad) {
        this.plan = plan;
        this.cantidad = cantidad;
        this.subtotal = plan.getPrecio() * cantidad;
    }

    public Plan getPlan() { return plan; }
    public void setPlan(Plan plan) { this.plan = plan; }
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
}