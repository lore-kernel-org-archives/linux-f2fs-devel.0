Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FBF606A32D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DZ5/6K3Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UWChuh1F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OH/Zzq/T;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pd+Ad0bz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=5Q+6FTWSvjFOD0bjemYFDpA9YQZ3k1BK0wHSbpj6/As=; b=DZ5/6K3Qar0FkokfgdIEPLHqGG
	+kPO+tajiLQIZPKryT0cl3JMeJgN3uuBonoP2NdHY8tH4NEkK/dTYwPtPc7b86sfs6Nm3563OezB7
	XbRk6sLxGdNUyaArIP5dbZFk4OfnJFwzPe6YMDMPNyJyc+JsC1RFh2WjaGhRQIy9IXE0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSKMC-000000004Me-2YUR;
	Sat, 14 Nov 2026 20:28:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xSKLZ-000000004IX-1ow7;
 Sat, 14 Nov 2026 20:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LfkfapyQaXHB8T99IkenQj1dMnikIM4i8S8xipB/rew=; b=UWChuh1FVLOyaLJvLfcWGnsxsp
 qcw7TQIkjRIz5J9hu94bYhf5YFv8wC6oeQeck5YihXxm7RmEk4znVjnrFPVQKCeC1Rt1FDXC9l1mm
 JnHDhXceiYR86dtG4tstCFAaYaVfhO6wvg7xhd7L8/8kwfuZeMYRihmZ/qnuFeN1eIl8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LfkfapyQaXHB8T99IkenQj1dMnikIM4i8S8xipB/rew=; b=OH/Zzq/T7+PxmF9MjlbBvwk8uv
 o8MZyPT86WOp4YAbiCR7zMWdy3TSaqMGR3fsLnCWz84OIENYGTsT8zrpls1LXFTXx48pOlNS81cIJ
 XjTNO7tpK45niVKdkmtwcRpc5YHy6/EiR+UR/IA2NxjFwzpj2+mbzWrdMQ9F+4gW3kb4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSKLY-000000005cp-0pkV; Sat, 14 Nov 2026 20:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=LfkfapyQaXHB8T99IkenQj1dMnikIM4i8S8xipB/rew=; b=pd+Ad0bzAd8xTR1JjwD4oFjSGH
 JfBYfPLz11DyfWWnkiCUkI7riV6CxKDnKVKGLpxlrMgBzDX5m7u0VSVAXnfPyoevCZ+ZrnzmUw1xL
 j/dWSsJdcdrnbhyY8ritNU8xSL3O7zBwc9uSDVYqQS+V9ePeGG32VV4wHyyag6NovMDPb+uJpnMRr
 NE6OQf8BRese+r6meXZlwtHULS8LPMXX6qKc4mh80jnCSKrNhE9WtW8Reypn75q6AFAkpAE1YtTH5
 ExpRINSRbfrwGa+9LBPo5ALgtbXk7CLpWN58t04LugKzbsJXVrD2V9/vlrQCT9ZZhfxwKqAxQiZf9
 AET5AX2g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xSKLF-0000000Giga-0jjJ; Sat, 14 Nov 2026 20:27:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 12:26:48 -0800
Message-ID: <20261114202653.3113381-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114202653.3113381-1-rdunlap@infradead.org>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSKLY-000000005cp-0pkV
Subject: [f2fs-dev] [PATCH 10/12] docs: ioctl-number: update FS entries
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Paulo Alcantara <pc@manguebit.org>, dri-devel@lists.freedesktop.org,
 Jaroslav Kysela <perex@perex.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Leon Romanovsky <leonro@nvidia.com>, Mike Marshall <hubcap@omnibond.com>,
 Matthew Brost <matthew.brost@intel.com>,
 linux-atm-general@lists.sourceforge.net, Tvrtko Ursulin <tursulin@ursulin.net>,
 xen-devel@lists.xenproject.org, devel@lists.orangefs.org,
 Neill Kapron <nkapron@google.com>, Chas Williams <3chas3@gmail.com>,
 linux-sound@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, David Hildenbrand <david@kernel.org>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Simona Vetter <simona@ffwll.ch>, linux-cifs@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, linux-fsdevel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>,
 oe-linux-nfc@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
 David Heidelberg <david@ixit.cz>, linux-f2fs-devel@lists.sourceforge.net,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Eric Dumazet <edumazet@kernel.org>, linux-mtd@lists.infradead.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, MPT-FusionLinux.pdl@broadcom.com,
 Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
 Marcel Holtmann <marcel@holtmann.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Benson Leung <bleung@chromium.org>, "Martin K. Petersen" <mkp@kernel.org>,
 linux-ext4@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
 David Airlie <airlied@gmail.com>, linux-scsi@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, intel-gfx@lists.freedesktop.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 virtualization@lists.linux.dev, linux-block@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@kernel.org>, intel-xe@lists.freedesktop.org,
 Juergen Gross <jgross@suse.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-bluetooth@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the list of files where filesystem ioctls are defined and update
the ranges of function numbers that are used.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
[Since having multiple maintainers trying to merge these would
cause some conflicts, it would be more manageable for Jon to
take all of these through the docs-next tree.]

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: devel@lists.orangefs.org
Cc: Paulo Alcantara <pc@manguebit.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

 Documentation/userspace-api/ioctl/ioctl-number.rst |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-next-20261113.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ linux-next-20261113/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -187,6 +187,7 @@ Code  Seq#    Include File
 'I'   all    linux/isdn.h                                              conflict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                         conflict!
 'I'   40-4F  linux/mISDNif.h                                           conflict!
+'I'   00     linux/inotify.h
 'K'   all    linux/kd.h
 'L'   00-1F  linux/loop.h                                              conflict!
 'L'   10-21  drivers/scsi/mpt3sas/mpt3sas_ctl.h                        conflict!
@@ -275,7 +276,7 @@ Code  Seq#    Include File
 'f'   00-1F  linux/ext2_fs.h                                           conflict!
 'f'   00-1F  linux/ext3_fs.h                                           conflict!
 'f'   00-0F  fs/jfs/jfs_dinode.h                                       conflict!
-'f'   00-0F  fs/ext4/ext4.h                                            conflict!
+'f'   00-2F  fs/ext4/ext4.h                                            conflict!
 'f'   00-0F  linux/fs.h                                                conflict!
 'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       conflict!
 'f'   13-27  linux/fscrypt.h
@@ -300,6 +301,7 @@ Code  Seq#    Include File
 'k'   00-0F  linux/spi/spidev.h                                        conflict!
 'k'   00-05  video/kyro.h                                              conflict!
 'k'   10-17  linux/hsi/hsi_char.h                                      HSI character device
+'k'   01-0F  fs/orangefs/protocol.h                                    <mailto:devel@lists.orangefs.org>
 'l'   00-3F  linux/tcfs_fs.h                                           transparent cryptographic file system
                                                                        <http://web.archive.org/web/%2A/http://mikonos.dia.unisa.it/tcfs>
 'l'   40-7F  linux/udf_fs_i.h                                          in development:
@@ -373,7 +375,7 @@ Code  Seq#    Include File
 0x92  00-0F  drivers/usb/mon/mon_bin.c
 0x93  60-7F  linux/auto_fs.h
 0x94  all    fs/btrfs/ioctl.h                                          Btrfs filesystem
-             and linux/fs.h                                            some lifted to vfs/generic
+0x94  all    linux/fs.h                                                some lifted from Btrfs to vfs/generic
 0x97  00-7F  fs/ceph/ioctl.h                                           Ceph file system
 0x99  00-0F                                                            537-Addinboard driver
                                                                        <mailto:buk@buks.ipn.de>
@@ -442,7 +444,7 @@ Code  Seq#    Include File
 0xCC  00-0F  drivers/misc/ibmvmc.h                                     pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h                                       Dead since 6.13
 0xCE  01-02  uapi/linux/cxl_mem.h                                      Compute Express Link Memory Devices
-0xCF  02     fs/smb/client/cifs_ioctl.h
+0xCF  01-0F  fs/smb/client/cifs_ioctl.h                                <mailto:linux-cifs@vger.kernel.org>
 0xDD  00-3F                                                            ZFCP device driver see drivers/s390/scsi/
                                                                        <mailto:aherrman@de.ibm.com>
 0xE5  00-3F  linux/fuse.h
@@ -451,6 +453,7 @@ Code  Seq#    Include File
 0xEF  00-0F  uapi/linux/ntfs.h                                         NTFS
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       sisfb
 0xF3  00-3F  video/sisfb.h                                             <mailto:thomas@winischhofer.net>
+0xF5  01-1F  uapi/linux/f2fs.h                                         <mailto:linux-f2fs-devel@lists.sourceforge.net>
 0xF6  all                                                              LTTng Linux Trace Toolkit Next Generation
                                                                        <mailto:mathieu.desnoyers@efficios.com>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                      AMD HSMP EPYC system management interface driver


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
