Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F3606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JQibl+QS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DuxyKdNA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IIL+iu2N;
	dkim=neutral header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=trPf9+9S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:References:
	In-Reply-To:To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FXLxK1hyPRZFdfeIvVLB8PBZQTBgBxxDbe/3SwkVRmg=; b=JQibl+QSxiQI8T
	rs5gXHnOh6XAvjneHOPY5T/AYyiQBfpTUZHCENy/2b46CXzoEvxXVrOJatgvTBEUR+i10uxbqntjR
	s930CtCbH1siYCCGgtl5FSSU4yGyhMr26RJd4r/vX/7hDWa4w1OHfRuNUEiUF9HKSywPmsagIfWaN
	vRc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTywB-000000002TY-1Ul8;
	Thu, 19 Nov 2026 10:00:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <miquel.raynal@bootlin.com>)
 id 1xTyw4-000000002Rc-1T2e
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQyK9hhzQUtdCIaKwh8qFL6kiw3hBK7e02jXrxk3Q5M=; b=DuxyKdNApAje3SCqurfIYVMbaI
 gX2p7RJ1T3Y+ntHBMSqELU9GZb3b6t6EN0lnfiBWRiS8t6dKwPhb2U79924j/eO6YYaU7+M3YYHMZ
 0ZTGG7na3GCtDnQCCcV9AtUPvfuy6IrR3u34QNezaSEmkOb/flnQW7+0rmsQCh9YVOKU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQyK9hhzQUtdCIaKwh8qFL6kiw3hBK7e02jXrxk3Q5M=; b=IIL+iu2Nhq/kdaRmQDSHxFv9L3
 hvFghiIQNrSYES/xihifmrwxQ/XEOs2xCvcTh06VOd7BXb0MqLr2QXu8qhZsDEpZXjd8k0F0MOuZu
 kPVGSPfTeYBxqBCjRC9N40TWZQB2odME4axVGwAEy7eT+C73y7ALY057+6oXuhXmRqdg=;
Received: from smtpout-04.galae.net ([185.171.202.116])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTyw2-0000000040u-0zbT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:00:08 +0000
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9242AC4CBEF;
 Thu, 19 Nov 2026 09:35:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3D3E660237;
 Thu, 19 Nov 2026 09:35:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 145C311BC315F; Thu, 19 Nov 2026 10:34:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795080902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CQyK9hhzQUtdCIaKwh8qFL6kiw3hBK7e02jXrxk3Q5M=;
 b=trPf9+9SmvXq7f3i06Ocu8PXp2wkKO6ORNKTA4/AjOKcQKVFePqcO/1BhMn+K4JKXgVetW
 9Yr+85a0u4rw/+pGQPZDRSMsRMDGawEXfnQ9jCtNv2zr3C8ZQd4iUe048cU50ECPRyFurf
 rsmMLyDo3rueQxG7RuwY+EBebjyTZuhqh1PyoyvCDfGRSYoPSTyfx/hwy85QgTWFsAil0Q
 X6TU5TJA2EpRSA3/3QyU7eQBfCRlHqNmOlSA+ByZVazhopQuZSLgxPNhpRVe5QgDh43L/T
 HBMPjxwGs9avJmS68J25IgXRGZqvRkZ+RC3EyDq//xlN7GCwXICCDykv7Bhitw==
To: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261119053514.255348-8-rdunlap@infradead.org> (Randy Dunlap's
 message of "Wed, 18 Nov 2026 21:35:08 -0800")
References: <20261119053514.255348-1-rdunlap@infradead.org>
 <20261119053514.255348-8-rdunlap@infradead.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 10:34:37 +0100
Message-ID: <87bj7lf9le.fsf@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTyw2-0000000040u-0zbT
Subject: Re: [f2fs-dev] [PATCH v2 07/12] docs: ioctl-number: update MTD
 entries
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Miquel Raynal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Benson Leung <bleung@chromium.org>,
 David Airlie <airlied@gmail.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mike Marshall <hubcap@omnibond.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, amd-gfx@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
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
 intel-xe@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, "Martin
 K. Petersen" <mkp@kernel.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6?= =?utf-8?Q?m?=
 <thomas.hellstrom@linux.intel.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Matthew Brost <matthew.brost@intel.com>,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 oe-linux-nfc@lists.linux.dev, Florian Fainelli <florian.fainelli@broadcom.com>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
 Takashi Iwai <tiwai@suse.com>, David Heidelberg <david@ixit.cz>,
 linux-f2fs-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUmFuZHksCgpPbiAxOC8xMS8yMDI2IGF0IDIxOjM1OjA4IC0wOCwgUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+IHdyb3RlOgoKPiBVcGRhdGUgdGhlIGxpc3Qgb2YgZmlsZXMg
d2hlcmUgTVREIGlvY3RscyBhcmUgZGVmaW5lZCBhbmQgdXBkYXRlCj4gdGhlIHJhbmdlcyBvZiBm
dW5jdGlvbiBudW1iZXJzIHRoYXQgYXJlIHVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBE
dW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KCkFja2VkLWJ5OiBNaXF1ZWwgUmF5bmFsIDxt
aXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgoKPiBbU2luY2UgaGF2aW5nIG11bHRpcGxlIG1haW50
YWluZXJzIHRyeWluZyB0byBtZXJnZSB0aGVzZSB3b3VsZAo+IGNhdXNlIHNvbWUgY29uZmxpY3Rz
LCBpdCB3b3VsZCBiZSBtb3JlIG1hbmFnZWFibGUgZm9yIEpvbiB0bwo+IHRha2UgYWxsIG9mIHRo
ZXNlIHRocm91Z2ggdGhlIGRvY3MtbmV4dCB0cmVlLl0KCkFncmVlZC4KClRoYW5rcywKTWlxdcOo
bAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
