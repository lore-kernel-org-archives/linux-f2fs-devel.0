From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: BUG: effect of immutable attribute (chattr +i) is
 gone after remount
Date: Tue, 16 May 2017 13:28:58 -0700
Message-ID: <20170516202858.GA16238@jaegeuk.local>
References: <HK2PR04MB064473E2C9EE4462A3BC0A5088E60@HK2PR04MB0644.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dAj5d-0007h5-Hj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 May 2017 20:29:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dAj5c-0007Sm-FM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 May 2017 20:29:05 +0000
Content-Disposition: inline
In-Reply-To: <HK2PR04MB064473E2C9EE4462A3BC0A5088E60@HK2PR04MB0644.apcprd04.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tom Yan <tom.ty89@outlook.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Tom,

On 05/16, Tom Yan wrote:
> Hi all.
> =

> Just happen to notice that=A0a file on my f2fs=A0filesystem marked as imm=
utable is actually "mutable". At first I thought it was because of file cor=
ruption or so, but after some test it appears that the effect will be gone =
anyway once the filesystem is remounted. The flag remains though, as per th=
e output of lsattr.
> =


Thank you so much for the report.

> Here is a test case:
> =

> [tom@localhost ~]$ truncate -s 256M f2fs.img
> [tom@localhost ~]$ sudo losetup -f f2fs.img =

> [tom@localhost ~]$ sudo mkfs.f2fs /dev/loop0 =

> =

> 	F2FS-tools: mkfs.f2fs Ver: 1.8.0 (2017-02-03)
> =

> Info: Debug level =3D 0
> Info: Label =3D =

> Info: Trim is enabled
> Info: Segments per section =3D 1
> Info: Sections per zone =3D 1
> Info: sector size =3D 512
> Info: total sectors =3D 524288 (256 MB)
> Info: zone aligned segment0 blkaddr: 512
> Info: format version with
>   "Linux version 4.10.13-1-ARCH (builduser@tobias) (gcc version 6.3.1 201=
70306 (GCC) ) #1 SMP PREEMPT Thu Apr 27 12:15:09 CEST 2017"
> Info: [/dev/loop0] Discarding device
> Info: This device doesn't support BLKSECDISCARD
> Info: Discarded 256 MB
> Info: Overprovision ratio =3D 15.000%
> Info: Overprovision segments =3D 35 (GC reserved =3D 21)
> Info: format successful
> [tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
> [tom@localhost ~]$ sudo chown tom:tom /mnt/
> [tom@localhost ~]$ touch /mnt/testfile
> [tom@localhost ~]$ sudo chattr +i /mnt/testfile =

> [tom@localhost ~]$ echo test > /mnt/testfile =

> bash: /mnt/testfile: Operation not permitted
> [tom@localhost ~]$ rm /mnt/testfile =

> rm: cannot remove '/mnt/testfile': Operation not permitted
> [tom@localhost ~]$ sudo umount /mnt/
> [tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
> [tom@localhost ~]$ lsattr /mnt/testfile =

> ----i-------------- /mnt/testfile
> [tom@localhost ~]$ echo test > /mnt/testfile =

> [tom@localhost ~]$ rm /mnt/testfile =

> [tom@localhost ~]$ sudo umount /mnt/
> [tom@localhost ~]$ uname -a
> Linux localhost 4.10.13-1-ARCH #1 SMP PREEMPT Thu Apr 27 12:15:09 CEST 20=
17 x86_64 GNU/Linux
> =

> As you can see, mkfs.f2fs is of version 1.8.0, and the kernel is as of 4.=
10.13. Let me know if you need further information. Thanks in advance.

I could simply reproduce this, and wrote a patch to fix it like below. ;)
Could you please check this patch as well?

Thanks,

>From 8aee3d3a0244802b141d1b2ae95c568d1aa26118 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 16 May 2017 13:20:16 -0700
Subject: [PATCH] f2fs: load inode's flag from disk

This patch fixes missing inode flag loaded from disk, reported by Tom.

[tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
[tom@localhost ~]$ sudo chown tom:tom /mnt/
[tom@localhost ~]$ touch /mnt/testfile
[tom@localhost ~]$ sudo chattr +i /mnt/testfile
[tom@localhost ~]$ echo test > /mnt/testfile
bash: /mnt/testfile: Operation not permitted
[tom@localhost ~]$ rm /mnt/testfile
rm: cannot remove '/mnt/testfile': Operation not permitted
[tom@localhost ~]$ sudo umount /mnt/
[tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
[tom@localhost ~]$ lsattr /mnt/testfile
----i-------------- /mnt/testfile
[tom@localhost ~]$ echo test > /mnt/testfile
[tom@localhost ~]$ rm /mnt/testfile
[tom@localhost ~]$ sudo umount /mnt/

Cc: stable@vger.kernel.org
Reported-by: Tom Yan <tom.ty89@outlook.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 518f49643092..7aab8837b6b4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -226,6 +226,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigne=
d long ino)
 		ret =3D -EIO;
 		goto bad_inode;
 	}
+	f2fs_set_inode_flags(inode);
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
-- =

2.11.0


---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
