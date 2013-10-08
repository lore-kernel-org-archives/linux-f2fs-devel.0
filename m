From: folkert <folkert@vanheusden.com>
Subject: f2fs using tons of cpu
Date: Tue, 8 Oct 2013 13:25:35 +0200
Message-ID: <20131008112534.GA24963@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1VTVgP-00048l-4Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 11:42:33 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VTVgN-0005RS-Fk
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 11:42:33 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: udovdh@xs4all.nl

Hi,

For the last few days f2fs started to use loads of cpu on one of my
raspberry pi systems:

  PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
 2822 root      20   0     0    0    0 R  35.3  0.0 328:34.01 f2fs_gc-254:0
 2826 root      20   0     0    0    0 R  35.3  0.0 327:40.07 flush-254:0

This is continuous load, the whole day.
This is to a SSD connected via USB:
Bus 001 Device 025: ID 0c45:7401 Microdia
The SSD does not support trim (that's why I put f2fs on it).

It is constantly reading (and not writing) data from the SSD it is on:

folkert@vnvnation ~ $ vmstat 2
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu--=
--
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id =
wa
 2  0      0  20744     16 375052    0    0 305774     0  413  157  0 100  =
0  0
 2  0      0  20744     16 375052    0    0 304272     0  409  151  0 100  =
0  0
 2  0      0  21536     16 375052    0    0 301444     0  410  163  0 100  =
0  0
 2  0      0  21536     16 375052    0    0 305052     0  408  150  0 100  =
0  0
 2  0      0  21536     16 375052    0    0 302994     0  407  151  0 100  =
0  0
 2  0      0  21932     16 375052    0    0 303408     0  406  153  0 100  =
0  0
 2  0      0  21932     16 375052    0    0 301580     0  417  152  1 99  0=
  0
 2  0      0  21932     16 375052    0    0 304142     0  411  150  0 100  =
0  0
 2  0      0  21932     16 375052    0    0 305944     0  409  152  0 100  =
0  0
 2  0      0  21932     16 375052    0    0 299700     0  414  156  0 100  =
0  0

It has lots of free diskspace left:

folkert@vnvnation ~ $ df -h /home/folkert/backups
Filesystem           Size  Used Avail Use% Mounted on
/dev/mapper/backups  118G   91G   27G  78% /home/folkert/backups

Kernel:

folkert@vnvnation ~ $ uname -r
3.9.8+


Folkert van Heusden

-- =

Multitail es una herramienta flexible que permite visualizar los "log
file" y seguir la ejecuci=F3n de comandos. Permite filtrar, a=F1adir
colores, combinar archivos, la visualizaci=F3n de diferencias (diff-
view), etc.  http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

---------------------------------------------------------------------------=
---
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most fr=
om =

the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=3D60134071&iu=3D/4140/ostg.cl=
ktrk
