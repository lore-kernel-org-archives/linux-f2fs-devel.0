Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9B606FAD6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CdE1bLi/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Um20isAa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UTaXN7I4;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BDu5SAtw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=bxCG9g8QXVRfY7Rj863TzOLbnMlxtNkrS8YoLmNmCyk=; b=CdE1bLi/0p5ty7s8hsrXqYZRzp
	JFQyJEV3wfg8GUg1Aez+V/CaXV8StIlLERPnnsz6d4g61ppKZohJyY8HE5RYgPaENJzzPZx4A+k9f
	jmQuM7M7J6wUf+ztynfhrKZWBkvu+gS9v5jfGmuQe9Oz1041EgZYRs977a5qqt1nPjs0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSKLm-000000003lS-2YG1;
	Sat, 14 Nov 2026 20:27:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xSKLU-000000003iH-1vZB;
 Sat, 14 Nov 2026 20:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DedKrhvyClXF9LtBnIx17a5S/VB8VLXfL0mdcjl2pPw=; b=Um20isAafkYgS6FbrLy1V634TD
 TLg3TnnqGB2wUIUrZD7GGZnOduCHUnRMrNZD0WskXEg4dC2ph8x1RaFP/BncCl92E/6xLxKZMIVXA
 7mwH4KyDELuQaWC4cwVuGLomSHPI/s2Wy3OeJymDux3n6fDUWVq9wmRp4JZh4bm+iY5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DedKrhvyClXF9LtBnIx17a5S/VB8VLXfL0mdcjl2pPw=; b=UTaXN7I4uo3wzQ5xIYKXnPqqLz
 bqETI5NxxNSwwIqYY+nVC61qgfVaQeCGXLxK7sr1QvVBBUcKMAI/wAolwVedFX9WB3hM2yNJE1Q54
 Q0AOhxERVnD+AkG9xeAV2ZdUDoi+esP+vdb3Z8iZ5nQZlc8ssLDPggohpyZ7KOCPy6MM=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSKLT-000000005EL-31bO; Sat, 14 Nov 2026 20:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=DedKrhvyClXF9LtBnIx17a5S/VB8VLXfL0mdcjl2pPw=; b=BDu5SAtwb3qtVN8B7fKoSynNCT
 d8mfgSQ79JqH2eiyIjrxvq1UNeZ3AEg9hUsOjkvb8i8bBea9eKyyvTCmdlHrsJ+6oOwmx93uD4PGr
 rDleVQXo2oD5ie/ZE9/xl1gNRVbx9MMw323qgK4s6+e1YMfIG3UQTx6fo7bqVuDfDWuz2M3kGdtPz
 a/oVIz440s54DJCpiJSupYODW8eABt40wMJ0VcdONwAKL2M7hxtFsIOiGmbDi0prIb0gCQSW2px3+
 zEufpgww751kDIjSiT8E+T7MpOX1MmtAdQkS2aaccKcmz8ud6HLXI1qT/x955lJ3WTj/MzF0UOGVi
 TzxUVRXQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xSKKz-0000000Giga-2aCy; Sat, 14 Nov 2026 20:27:01 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 12:26:41 -0800
Message-ID: <20261114202653.3113381-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114202653.3113381-1-rdunlap@infradead.org>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSKLT-000000005EL-31bO
Subject: [f2fs-dev] [PATCH 03/12] docs: ioctl-number: update block entries
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

Update the list of files where block ioctls are defined.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
[Since having multiple maintainers trying to merge these would
cause some conflicts, it would be more manageable for Jon to
take all of these through the docs-next tree.]

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org

 Documentation/userspace-api/ioctl/ioctl-number.rst |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20261111.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ linux-next-20261111/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -78,6 +78,7 @@ Code  Seq#    Include File
 0x00  00-1F  linux/fb.h                                                conflict!
 0x00  00-1F  linux/wavefront.h                                         conflict!
 0x02  all    linux/fd.h
+             drivers/block/floppy.c
 0x03  all    linux/hdreg.h
 0x04  D2-DC  linux/umsdos_fs.h                                         Dead since 2.6.11, but don't reuse these.
 0x06  all    linux/lp.h
@@ -90,6 +91,9 @@ Code  Seq#    Include File
              linux/blkpg.h
              linux/blkzoned.h
              linux/blk-crypto.h
+             linux/blkdev.h
+             linux/blktrace_api.h
+             block/ioctl.c
 0x15  all    linux/fs.h                                                FS_IOC_* ioctls
 0x1b  all                                                              InfiniBand Subsystem
                                                                        <http://infiniband.sourceforge.net/>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
