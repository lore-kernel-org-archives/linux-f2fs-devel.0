Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F960A5BCA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hXM0ZRzw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dANELNCb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JTsGRa0O;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CrVDzmrc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=0HDOoIMhlhbyOUnocJ5PRUE11HIhhA7U4MjpnoohRV0=; b=hXM0ZRzwdEyxiD4p+iuxbd/8mP
	v+sRxuo0tewDVibFYFS68tI7YSx5ISJ6BuzyjYjouF3FBC7L0APCIGCrkdzrWCNLb99reaj4Q1G+K
	S+Sj3S+86HaOTTe0bnzJXZ1MtKOmTY46H8cJBz+QRX8WxQmPZsv2kYzRIAvJH6OgrIGE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTuoH-000000006IB-0PLJ;
	Thu, 19 Nov 2026 05:35:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xTuoF-000000006I3-38rS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wxf1C03XM0J3zRYLBJ6bAuRpCxjKZ85wIDqTXFJZY0U=; b=dANELNCbUVrTENNmlT0shJuoEL
 DmP2F2Ukhd2Ii4zbqTof/FI4s6Y1vdjJbwlHRBcl7EGsLk5ny2KgXG08nJgQxZ/VF3ZKc4MCon+Aa
 Tk8H1XU6hb66lkxgNpIAC0wrS8DubpR+ra6xVZExBu++D1w6W2POvTm6aBvIUeRoOs18=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wxf1C03XM0J3zRYLBJ6bAuRpCxjKZ85wIDqTXFJZY0U=; b=JTsGRa0OIau/BvWREtNB1FU/qq
 xBCl7PGvEHIlo7FUUOGaAz/MVlSoFXlWnAYqld6JSZVHrjuKN5bdFbU7yHtl2KYJZnJgUc9yS/z3b
 DRT1X+CnL4o0/nAN8pDGCI4IlrgWBldcumsx9FgKF+aXrBk97ovEgvaNbuf6jhgYitWo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTuoE-0000000048Z-2b6n
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Wxf1C03XM0J3zRYLBJ6bAuRpCxjKZ85wIDqTXFJZY0U=; b=CrVDzmrc3oIthRH1y3T/xDyXPx
 cVrzHc8Q5zx9vBvBKySfZpSp9nn6Ctv4spyKdLZ2gMql4p4lGywVFn4Wxv0urKoLYE2Us8NFQbg/E
 SujAsyVlT9ZQaUAWuZ4Y5/PYoP053/q4PLQfGDqnfJt8K/Qo/9TEt1lbXZ4Egas/dHptyNhLgoYTF
 wuP3r+hQInGzK5spo+RZUspvYd5bw0PEETZbVVIV6tTzJx88fApDgP6f1LXwPqMwhToEckWSwFXKs
 1BcxQ0o6Vx/Qelp2qicLQ22b1mh0dYnsD+nVH3ZPFTcBV3vA7o28QrM93KssD+4D+Q51xT+SBXnFA
 FTl/MrJQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTuns-0000000Aufu-3YX5; Thu, 19 Nov 2026 05:35:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 21:35:03 -0800
Message-ID: <20261119053514.255348-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119053514.255348-1-rdunlap@infradead.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTuoE-0000000048Z-2b6n
Subject: [f2fs-dev] [PATCH v2 02/12] docs: ioctl-number: update sound entries
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
 David Airlie <airlied@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Leon Romanovsky <leonro@nvidia.com>, Mike Marshall <hubcap@omnibond.com>,
 Simona Vetter <simona@ffwll.ch>, linux-cifs@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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

Update the list of files where sound ioctls are defined and update
the ranges of function numbers that are used.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
v2: add Rev-by: from Takashi Sakamoto;
    address several review comments from sashiko

[Since having multiple maintainers trying to merge these would
cause some conflicts, it would be more manageable for Jon to
take all of these through the docs-next tree.]

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org

 Documentation/userspace-api/ioctl/ioctl-number.rst |   14 ++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- linux-next-20261116.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ linux-next-20261116/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -122,11 +122,14 @@ Code  Seq#    Include File
 'A'   00-0F  linux/agpgart.h,                                          conflict!
              drivers/char/agp/compat_ioctl.h
 'A'   00-7F  sound/asound.h                                            conflict!
+'A'   20-24  sound/pcm.h                                               conflict!
+'A'   10-53  sound/core/pcm_compat.c                                   conflict!
 'B'   00-1F  linux/cciss_ioctl.h                                       conflict!
 'B'   00-0F  include/linux/pmu.h                                       conflict!
 'B'   C0-FF  advanced bbus                                             <mailto:maassen@uni-freiburg.de>
 'B'   00-0F  xen/xenbus_dev.h                                          conflict!
 'C'   all    linux/soundcard.h                                         conflict!
+'C'   00-68  sound/compress_offload.h                                  conflict!
 'C'   01-2F  linux/capi.h                                              conflict!
 'C'   F0-FF  drivers/net/wan/cosa.h                                    conflict!
 'D'   all    arch/s390/include/asm/dasd.h
@@ -152,6 +155,7 @@ Code  Seq#    Include File
 'H'   01     linux/mei.h                                               conflict!
 'H'   02     linux/mei.h                                               conflict!
 'H'   03     linux/mei.h                                               conflict!
+'H'   03     sound/core/hwdep_compat.c                                 conflict!
 'H'   00-0F  sound/asound.h                                            conflict!
 'H'   20-40  sound/asound_fm.h                                         conflict!
 'H'   80-8F  sound/sfnt_info.h                                         conflict!
@@ -161,6 +165,7 @@ Code  Seq#    Include File
 'H'   40-4F  sound/hdspm.h                                             conflict!
 'H'   40-4F  sound/hdsp.h                                              conflict!
 'H'   90     sound/usb/usx2y/usb_stream.h
+'H'   FC     sound/pci/asihpi/hpios.h                                  conflict!
 'H'   00-0F  uapi/misc/habanalabs.h                                    conflict!
 'H'   A0     uapi/linux/usb/cdc-wdm.h
 'H'   C0-F0  net/bluetooth/hci.h                                       conflict!
@@ -168,7 +173,7 @@ Code  Seq#    Include File
 'H'   C0-DF  net/bluetooth/cmtp/cmtp.h                                 conflict!
 'H'   C0-DF  net/bluetooth/bnep/bnep.h                                 conflict!
 'H'   F1     linux/hid-roccat.h                                        <mailto:erazor_de@users.sourceforge.net>
-'H'   F8-FA  sound/firewire.h
+'H'   F8-FE  sound/firewire.h                                          conflict!
 'I'   all    linux/isdn.h                                              conflict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                         conflict!
 'I'   40-4F  linux/mISDNif.h                                           conflict!
@@ -204,6 +209,9 @@ Code  Seq#    Include File
 'S'   80-81  scsi/scsi_ioctl.h                                         conflict!
 'S'   82-FF  scsi/scsi.h                                               conflict!
 'S'   00-7F  sound/asequencer.h                                        conflict!
+'S'   20-52  sound/core/seq/seq_compat.c                               conflict!
+'S'   60-63  sound/scarlett2.h                                         conflict!
+'S'   60-67  sound/fcp.h                                               conflict!
 'T'   all    linux/soundcard.h                                         conflict!
 'T'   00-AF  sound/asound.h                                            conflict!
 'T'   all    arch/x86/include/asm/ioctls.h                             conflict!
@@ -219,8 +227,8 @@ Code  Seq#    Include File
 'V'   C0     media/si4713.h                                            conflict!
 'W'   00-1F  linux/watchdog.h                                          conflict!
 'W'   00-1F  linux/wanrouter.h                                         conflict! (pre 3.9)
-'W'   00-3F  sound/asound.h                                            conflict!
-'W'   40-5F  drivers/pci/switch/switchtec.c
+'W'   00-41  sound/asound.h                                            conflict!
+'W'   40-5F  drivers/pci/switch/switchtec.c                            conflict!
 'W'   60-61  linux/watch_queue.h
 'X'   all    fs/xfs/xfs_fs.h,                                          conflict!
              fs/xfs/linux-2.6/xfs_ioctl32.h,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
