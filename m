Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BE606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lxkFl8Lc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vdavn4z0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AQumH5mn;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gtc+5H4v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=T2FJuyTEhHlulTkCKbKAsnulOtFj93fQZBdREWFIf7A=; b=lxkFl8LcNu0nx2ohEgDHU1K57J
	q/Br4yz0YfdcHZC8Ix/c1+8w5uFYm6s9Bb9tpcX8O7Ae9d5McZ+IO54L+gQIG6k1C++759p1mgAIP
	1KYv3TWeGksO+TNLE12wNxAEX6/YqkhroiVQSpz7XPEPTaq3DIS7WwayA0KHb5Efhnvk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTuoX-000000006lI-2vV5;
	Thu, 19 Nov 2026 05:36:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xTuoV-000000006ke-2Jbx
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZuZZE/Cj353sLaHKMo9GpZj59G0w2nJ8ZNrbV6CJF+E=; b=Vdavn4z0MEh4ndWk1wFvBEueAv
 lw96efOxckpxFuiplvK04Yzf6KDAvHfn0CFmJUDX5lkMLq7gBB9Bjn7Af62yYljt5QxD+ODZ8Iqm2
 jDSgrO4ak6q4cQd8GiMEZltNL9O1Lu8rka0El8U+BV/lLCJrGhJiEhgPjgvD1P9EZ5D0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZuZZE/Cj353sLaHKMo9GpZj59G0w2nJ8ZNrbV6CJF+E=; b=AQumH5mnXIwsdARfoIh7ToaktM
 R6M4zpLpy7eyxuh6KOOVzhzydt1Zd6JAH1psAtdHLn3oIAGp1H1FBQ+8et+oNNiBdPzcEgwmtz7zl
 5KYTKrINtArYTNCXes005ZApwWV0Gzr6TQ1rboK2dKz72BGujaDi+7CXZDPwc4+S83C4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTuoU-000000003CH-09PY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ZuZZE/Cj353sLaHKMo9GpZj59G0w2nJ8ZNrbV6CJF+E=; b=gtc+5H4vdXyFU3qU5Duvifa7ky
 InKyXCzbLFZPDermXy3rctqSOxXlVD1xhaqgaam3o7dXL+dT1Zn4X6wKOoEgKwIMl/q3ii/4OE4Pj
 dD0/qIcPCOwrOsHurPjU5DuVLdgKUQVnbNOsgBDux7NNSuius0piP8K/4MVBRsbOy+Wj68w4MoEQV
 /yC6Yd5GetCjVDa4xZMHsOHzcxle7zKJPDj+ugtM3NXeqkNIslDkyVkcFfX10ZJT9o8fsAdX+iu3R
 qGfKSoWF06eIb33qIg9Z83bTojP/bNXJ1y/jnaz3znGe2T3I1Qni4iZwIQSmr5aLyhvr6uLH/rVHu
 EMPOBZ5w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTuoE-0000000Aufu-0eli; Thu, 19 Nov 2026 05:35:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 21:35:11 -0800
Message-ID: <20261119053514.255348-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119053514.255348-1-rdunlap@infradead.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTuoU-000000003CH-09PY
Subject: [f2fs-dev] [PATCH v2 10/12] docs: ioctl-number: update FS entries
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Vignesh Raghavendra <vigneshr@ti.com>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, Benson Leung <bleung@chromium.org>,
 David Airlie <airlied@gmail.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mike Marshall <hubcap@omnibond.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, amd-gfx@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MPT-FusionLinux.pdl@broadcom.com, Namjae Jeon <linkinjeon@kernel.org>,
 devel@lists.orangefs.org, Neill Kapron <nkapron@google.com>,
 Juergen Gross <jgross@suse.com>, Chas Williams <3chas3@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>,
 Sean Christopherson <seanjc@google.com>, virtualization@lists.linux.dev,
 linux-sound@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 linux-block@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, David Hildenbrand <david@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Matthew Brost <matthew.brost@intel.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, oe-linux-nfc@lists.linux.dev,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Paulo Alcantara <pc@manguebit.org>,
 Takashi Iwai <tiwai@suse.com>, David Heidelberg <david@ixit.cz>,
 linux-f2fs-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Hans de Goede <hansg@kernel.org>
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
v2: address sashiko review comment (ext4 00-2F range referred to
    the wrong file name)

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

--- linux-next-20261116.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ linux-next-20261116/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -185,6 +185,7 @@ Code  Seq#    Include File
 'I'   all    linux/isdn.h                                              conflict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                         conflict!
 'I'   40-4F  linux/mISDNif.h                                           conflict!
+'I'   00     linux/inotify.h
 'K'   all    linux/kd.h
 'L'   00-1F  linux/loop.h                                              conflict!
 'L'   10-21  drivers/scsi/mpt3sas/mpt3sas_ctl.h                        conflict!
@@ -274,7 +275,7 @@ Code  Seq#    Include File
 'f'   00-1F  linux/ext2_fs.h                                           conflict!
 'f'   00-1F  linux/ext3_fs.h                                           conflict!
 'f'   00-0F  fs/jfs/jfs_dinode.h                                       conflict!
-'f'   00-0F  fs/ext4/ext4.h                                            conflict!
+'f'   00-2F  fs/ext4/ext4.h, uapi/linux/ext4.h                         conflict!
 'f'   00-0F  linux/fs.h                                                conflict!
 'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       conflict!
 'f'   13-27  linux/fscrypt.h
@@ -299,6 +300,7 @@ Code  Seq#    Include File
 'k'   00-0F  linux/spi/spidev.h                                        conflict!
 'k'   00-05  video/kyro.h                                              conflict!
 'k'   10-17  linux/hsi/hsi_char.h                                      HSI character device
+'k'   01-0F  fs/orangefs/protocol.h                                    <mailto:devel@lists.orangefs.org>
 'l'   00-3F  linux/tcfs_fs.h                                           transparent cryptographic file system
                                                                        <http://web.archive.org/web/%2A/http://mikonos.dia.unisa.it/tcfs>
 'l'   40-7F  linux/udf_fs_i.h                                          in development:
@@ -372,7 +374,7 @@ Code  Seq#    Include File
 0x92  00-0F  drivers/usb/mon/mon_bin.c
 0x93  60-7F  linux/auto_fs.h
 0x94  all    fs/btrfs/ioctl.h                                          Btrfs filesystem
-             and linux/fs.h                                            some lifted to vfs/generic
+0x94  all    linux/fs.h                                                some lifted from Btrfs to vfs/generic
 0x97  00-7F  fs/ceph/ioctl.h                                           Ceph file system
 0x99  00-0F                                                            537-Addinboard driver
                                                                        <mailto:buk@buks.ipn.de>
@@ -440,7 +442,7 @@ Code  Seq#    Include File
 0xCC  00-0F  drivers/misc/ibmvmc.h                                     pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h                                       Dead since 6.13
 0xCE  01-02  uapi/linux/cxl_mem.h                                      Compute Express Link Memory Devices
-0xCF  02     fs/smb/client/cifs_ioctl.h
+0xCF  01-0F  fs/smb/client/cifs_ioctl.h                                <mailto:linux-cifs@vger.kernel.org>
 0xDD  00-3F                                                            ZFCP device driver see drivers/s390/scsi/
                                                                        <mailto:aherrman@de.ibm.com>
 0xE5  00-3F  linux/fuse.h
@@ -449,6 +451,7 @@ Code  Seq#    Include File
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
