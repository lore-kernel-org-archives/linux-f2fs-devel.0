Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B8607358F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DaHpxrLH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QEF24l3E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pyj5IRGD;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3pquZVZA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=kaf5EoZcK2Ewi482MvHnDgxfwA5Dl2KwWotoodoGsrw=; b=DaHpxrLHmTQfdwarIZdI3GzzjK
	b5OLNAo7M3Wmxw3OCnlFvInNlt1OxmsmbHUNUrEWEtU/JeJkkNSGKEr87ysuFRbB8n+0lJiH7xlCP
	pIDndWdI+k1/qSI4UTx880JQIvO22r8FPqEsFpIRYARkVTpb9Hah2NJjJ0QozXk9Txo4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSKLW-000000003id-1xF3;
	Sat, 14 Nov 2026 20:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xSKLP-000000003hi-1x4w;
 Sat, 14 Nov 2026 20:27:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tmHKbAmxa6ArfnJ6gJ4VyhMIyEYWb9jJaJtmM71QRoI=; b=QEF24l3E1oKe4fcAHPQb/CkzEy
 58LG1wsxg588MJEDZnnhaGizKdkw4UDzHnLRQ8JkLws5OkrhiPAzNTR16GjOo0sqZpVWKUt4xtaEh
 B0w4dQWEG7aoAOlnn92d1xOy1euc5Vgxdo5xLUvSh4a7APpX93H/9cI3n4xodS8xmlgs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tmHKbAmxa6ArfnJ6gJ4VyhMIyEYWb9jJaJtmM71QRoI=; b=Pyj5IRGDEUUrCDxt38fqR0Jv1Z
 tos0NJmX/NOzSUD4JDKC75xbl4loWrMuHhy3M5IvVHfoq5lIVUzSYpgbciHWf2cEG3G0d2tljrwA7
 vjSMsWnvLXxb0A3c9ki4RalnjhjFoacFwtRj/pMp7egEcEIkdBxt7qKgwRq+8mSxUOQk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSKLN-000000005cT-2lK3; Sat, 14 Nov 2026 20:27:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=tmHKbAmxa6ArfnJ6gJ4VyhMIyEYWb9jJaJtmM71QRoI=; b=3pquZVZA3xXfR1zKOlsLTgQewp
 6L3A4hmklS6cWuQPp4vAHrmMD+Mf6hZ0D8rnZbmBsOrP8+4UCu4Huopqs8MjmolIxvH4Nn8xsEwqi
 hYNi5bO70Ir/MQ7Q1kA6XJ/nZF9qVkFoKC+Kyv2GReF7FMI2bmVer0cXfw8GmQvuqFRC6m8s2g5ZC
 XNUgHj8PkYG8nycQu1Uf58e2s4r3bcySyAZvAnY/VuzD6osLqgalvwYRXAOieEaS92e/WwFha3ew1
 2tpccHBaYigDGYD7BtDdwpyQhE2Wgi6476i7/URJGlnfEVH7+SZnD/IwI2SjPPV1U53zeFF0YrPTl
 GfmH0flQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xSKLB-0000000Giga-0GrV; Sat, 14 Nov 2026 20:27:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 12:26:46 -0800
Message-ID: <20261114202653.3113381-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114202653.3113381-1-rdunlap@infradead.org>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSKLN-000000005cT-2lK3
Subject: [f2fs-dev] [PATCH 08/12] docs: ioctl-number: update USB entries
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

Update the list of files where USB ioctls are defined.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
[Since having multiple maintainers trying to merge these would
cause some conflicts, it would be more manageable for Jon to
take all of these through the docs-next tree.]

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org

 Documentation/userspace-api/ioctl/ioctl-number.rst |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20261111.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ linux-next-20261111/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -234,6 +234,9 @@ Code  Seq#    Include File
 'U'   00-EF  linux/usbdevice_fs.h
 'U'   C0-CF  drivers/bluetooth/hci_uart.h
 'U'   00     net/nfc/nci_core.h                                        conflict!
+'U'   00-0F  linux/usb/raw_gadget.h                                    conflict!
+'U'   01     linux/usb/g_uvc.h                                         conflict!
+'U'   64     drivers/usb/misc/usbtest.c                                conflict!
 'V'   all    linux/vt.h                                                conflict!
 'V'   all    linux/videodev2.h                                         conflict!
 'V'   C0     linux/ivtvfb.h                                            conflict!
@@ -280,6 +283,9 @@ Code  Seq#    Include File
 'g'   20-2F  linux/usb/g_printer.h
 'g'   01-0F  mm/gup_test.h                                             conflict!
                                                                        <mailto:linux-mm@kvack.org>
+'g'   01-03  linux/usb/functionfs.h                                    conflict!
+      80-86
+'g'   41-42  linux/usb/g_hid.h
 'h'   00-7F                                                            conflict! Charon filesystem
                                                                        <mailto:zapman@interlan.net>
 'h'   00-1F  linux/hpet.h                                              conflict!


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
