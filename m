From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: f2fs unmount hangs if f2fs_init_acl() fails during mkdir
 syscall
Date: Fri, 07 Feb 2014 09:49:45 +0900
Message-ID: <1391734185.25542.80.camel@kjgkr>
References: <52F320FC.50803@ispras.ru> <1391666564.25542.78.camel@kjgkr>
 <52F37D67.208@ispras.ru>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <52F37D67.208@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Tsyvarev <tsyvarev@ispras.ru>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2014-02-06 (=EB=AA=A9), 16:17 +0400, Andrey Tsyvarev:
> Hi,
>=20
> 06.02.2014 10:02, Jaegeuk Kim =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi,
> >
> > Thank you for the test and valuable report.
> >
> > This bug was fixed recently by:
> >
> > commit 03dea3129d558bf5293a6e9f12777176619ac876
> > Author: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > Date:   Wed Feb 5 11:16:39 2014 +0900
> >
> >      f2fs: fix to truncate dentry pages in the error case
> Now remove_inode_page() succeed, but another assertion failed (tested=
 on=20
> revision e964751c):
>=20
> [ 1272.747011] kernel BUG at fs/f2fs/inode.c:274!
> [ 1272.747011] invalid opcode: 0000 [#1] SMP
> [ 1272.747011] Modules linked in: f2fs kedr_fsim_indicator_common(OF)=
=20
> kedr_fsim_indicator_capable(OF)
> kedr_fsim_indicator_kmalloc(OF) kedr_fsim_vmm(OF) kedr_fsim_mem_util(=
OF)=20
> kedr_fsim_capable(OF)
> kedr_fsim_uaccess(OF) kedr_fsim_cmm(OF) kedr_fault_simulation(OF)=20
> kedr(OF) fuse nf_conntrack_netbios_ns
> nf_conntrack_broadcast ipt_MASQUERADE ip6t_REJECT xt_conntrack=20
> ebtable_nat ebtable_broute bridge stp
> llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6=20
> nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
> ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat=
=20
> nf_conntrack_ipv4 nf_defrag_ipv4
> nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security=20
> iptable_raw parport_pc i2c_piix4 e1000
> i2c_core microcode parport ata_generic pata_acpi [last unloaded: kedr=
]
> [ 1272.747011] CPU: 0 PID: 14613 Comm: fs-driver-tests Tainted: GF   =
   =20
> W  O 3.14.0-rc1fs #1
> [ 1272.747011] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIO=
S=20
> VirtualBox 12/01/2006
> [ 1272.747011] task: ffff88001e939190 ti: ffff88000d7ec000 task.ti:=20
> ffff88000d7ec000
> [ 1272.747011] RIP: 0010:[<ffffffffa01c74a8>] [<ffffffffa01c74a8>]=20
> f2fs_evict_inode+0x178/0x180 [f2fs]
> [ 1272.747011] RSP: 0018:ffff88000d7ede50  EFLAGS: 00010202
> [ 1272.747011] RAX: 0000000000000001 RBX: ffff88000475cc30 RCX:=20
> ffff88001e9398a0
> [ 1272.747011] RDX: 0000000000000002 RSI: 0000000000000000 RDI:=20
> ffff88000475ce10
> [ 1272.747011] RBP: ffff88000d7ede68 R08: 00000000ffffffff R09:=20
> 0000000000000000
> [ 1272.747011] R10: 0000000000000000 R11: 0000000000000001 R12:=20
> ffff88000475cc30
> [ 1272.747011] R13: ffff88000f147800 R14: ffffffffa01e7080 R15:=20
> ffff88000f147b80
> [ 1272.747011] FS:  00007f1795424740(0000) GS:ffff88003fc00000(0000)=20
> knlGS:0000000000000000
> [ 1272.747011] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 1272.747011] CR2: 00007fc33bfa9000 CR3: 000000000f14e000 CR4:=20
> 00000000000006f0
> [ 1272.747011] Stack:
> [ 1272.747011]  ffff88000475cc30 ffff88000475cdc8 ffffffffa01e7080=20
> ffff88000d7ede90
> [ 1272.747011]  ffffffff811fde03 ffff88000475cc30 ffff88000475ccb8=20
> ffff88000f147000
> [ 1272.747011]  ffff88000d7edec0 ffffffff811fe615 ffff88000475cc30=20
> ffff88000f147800
> [ 1272.747011] Call Trace:
> [ 1272.747011]  [<ffffffff811fde03>] evict+0xa3/0x1a0
> [ 1272.747011]  [<ffffffff811fe615>] iput+0xf5/0x180
> [ 1272.747011]  [<ffffffffa01c7f63>] f2fs_mkdir+0xf3/0x150 [f2fs]
> [ 1272.747011]  [<ffffffff811f2a77>] vfs_mkdir+0xb7/0x160
> [ 1272.747011]  [<ffffffff811f36bf>] SyS_mkdir+0x5f/0xc0
> [ 1272.747011]  [<ffffffff81680769>] system_call_fastpath+0x16/0x1b
> [ 1272.747011] Code: 01 e1 4c 89 e7 e8 39 59 03 e1 5b 41 5c 41 5d 5d =
c3=20
> 31 c0 49 83 bc 24 c8 00 00 00 01 0f 97 c0
> eb 8f 4c 89 e7 e8 fa ec ff ff eb 89 <0f> 0b 66 0f 1f 44 00 00 0f 1f 4=
4=20
> 00 00 55 48 c7 c0 dc ff ff ff
> [ 1272.747011] RIP  [<ffffffffa01c74a8>] f2fs_evict_inode+0x178/0x180=
 [f2fs]
> [ 1272.747011]  RSP <ffff88000d7ede50>
>=20
> Failed assertion claims that dirty dentries counter should be zero wh=
en=20
> inode is deleted.
> This counter is incremented by
> mkdir()->
>    f2fs_add_link()->
>      init_inode_metadata()->
>        make_empty_dir()->
>          set_page_dirty();
>=20
> but no one decrement it.
> May be, this should be done along with truncating directory inode in=20
> error-path of init_inode_metadata() ?

It's weird, since original intention was that pages should be
invalidated by:
f2fs_evict_inode
 - truncate_inode_pages
   - f2fs_invalidate_page
      - decrement dirty_dents

I'll see what happened a little bit more.
Thanks,

>=20
>=20
> --
> Best regards,
> Andrey Tsyvarev
> Linux Verification Center, ISPRAS
> web: http://linuxtesting.org
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Jaegeuk Kim
Samsung
