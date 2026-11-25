Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F45607025F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UXkS+iHK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wc7cZlo/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cvNxHn0Z;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RqltCb+4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=gGQHOb00y7Wkx7XZon4UMK0nr8hSEN6vluE3WZrKQZ8=; b=UXkS+iHKVD7T57DA1oziKyfMT1
	vLGwJpK/JG/dfImT9UgI1Gt/7/FmOKPlcZZcKqPfH2ZCqe1pT6qXqjLU7NdGGzc/34+wYzf7KEJ4S
	CWVRywOv35W5o5Or8GS4/C94dC1SPyCIMeai4/pzRKOk5sNHWhd2cPBBa5CP7LSHiUSM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW6Gn-000000006fu-0Qtk;
	Wed, 25 Nov 2026 06:14:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xW6Gl-000000006fm-2P7Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1lJ3K/EilkHlytmEnlIWdtZUx18zfJBzx5n6NoVgMZA=; b=Wc7cZlo/jA5AvaYxQ7x7s4/f0W
 ywVxYgL+sWmLgXKFl4V832+wCmCZyiXbR51+QGcM2n8C6ViGR52N+DZjTaXaJ9CMbTQeVoackzNbU
 qU0KG/IcPThmKvzhWCz3vrcoC4XcSmtJzgcPxGDNlq0mzzuLOh/61+sdCvT3OUCH2X4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1lJ3K/EilkHlytmEnlIWdtZUx18zfJBzx5n6NoVgMZA=; b=cvNxHn0Zh9qg+4m7cnT7185OMo
 0wk9GMOm5ziZ8ZyIXrOatN45lTEc0ztNPlSVf+mhm+xfP1R7GoRqbTph54ndXR0m/DRm4Z87dru4j
 nOSw6PdzffVaE6I9V4oaR2X8V+bG/0QwRHIEtKJfOCQGnPuTzMzuQjTZCZrXxma3NQcY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW6Gi-000000007NG-1lul
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=1lJ3K/EilkHlytmEnlIWdtZUx18zfJBzx5n6NoVgMZA=; b=RqltCb+47NdqyaEvOeyiNTu41X
 84FUK7YH1lzhc+XRDU7RDe1ATmwD2JLDQQHYXSptW+C8cOoyJXaeMMoxDrj52mgJbJABc7Wp7C6Ek
 yMmn7sxUNjG9+JacqyjWHOLLSx44CbPR/BUHV3axpjiiSm5gCjQQXyxxA7H3gdH1t4MGWdJOzFgY/
 LdhuYc4NBwg0ll800pMNrxw416aXG455yKA7ZRyCJXxDYUE7E96+EFTBNvaDVaODEWfUflZDK22Vc
 WudMF3wjFMpxyZ/vO15PD+q5sQEnuA9btI8rOSE+Z/fRZgBFloydCASmKFi4tcauXjXpi+0t0+GV5
 I+QiQsxQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xW6GF-00000008Wvh-2FgZ; Wed, 25 Nov 2026 06:13:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 22:13:27 -0800
Message-ID: <20261125061340.3402300-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xW6Gi-000000007NG-1lul
Subject: [f2fs-dev] [PATCH v3 00/12] docs: ioctl-number: update entries
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VXBkYXRlIGZpbGUgbmFtZXMgdGhhdCBkZWZpbmUgaW9jdGxzIGFuZCB1cGRhdGUgdGhlIHJhbmdl
IG9mCmlvY3RsIGZ1bmN0aW9uIG51bWJlcnMgdGhhdCBhcmUgdXNlZCB3aGVyZSB0aGV5IGhhdmUg
Y2hhbmdlZC4KCltTaW5jZSBoYXZpbmcgbXVsdGlwbGUgbWFpbnRhaW5lcnMgdHJ5aW5nIHRvIG1l
cmdlIHRoZXNlIHdvdWxkCmNhdXNlIHNvbWUgY29uZmxpY3RzLCBpdCB3b3VsZCBiZSBtb3JlIG1h
bmFnZWFibGUgZm9yIEpvbiB0bwp0YWtlIGFsbCBvZiB0aGVzZSB0aHJvdWdoIHRoZSBkb2NzLW5l
eHQgdHJlZS5dCgogW1BBVENIIDAxLzEyIHYyXSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0ZSBN
TSBlbnRyaWVzCiBbUEFUQ0ggMDIvMTIgdjJdIGRvY3M6IGlvY3RsLW51bWJlcjogdXBkYXRlIHNv
dW5kIGVudHJpZXMKIFtQQVRDSCAwMy8xMiB2Ml0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUg
YmxvY2sgZW50cmllcwogW1BBVENIIDA0LzEyIHYyXSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0
ZSBuZXR3b3JraW5nIGVudHJpZXMKIFtQQVRDSCAwNS8xMiB2Ml0gZG9jczogaW9jdGwtbnVtYmVy
OiB1cGRhdGUgdmlkZW8vZmJkZXYgZW50cmllcwogW1BBVENIIDA2LzEyIHYyXSBkb2NzOiBpb2N0
bC1udW1iZXI6IHVwZGF0ZSBTQ1NJIGVudHJpZXMKIFtQQVRDSCAwNy8xMiB2Ml0gZG9jczogaW9j
dGwtbnVtYmVyOiB1cGRhdGUgTVREIGVudHJpZXMKIFtQQVRDSCAwOC8xMiB2Ml0gZG9jczogaW9j
dGwtbnVtYmVyOiB1cGRhdGUgVVNCIGVudHJpZXMKIFtQQVRDSCAwOS8xMiB2Ml0gZG9jczogaW9j
dGwtbnVtYmVyOiB1cGRhdGUgdmlydHVhbGl6YXRpb24gZW50cmllcwogW1BBVENIIDEwLzEyIHYy
XSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0ZSBGUyBlbnRyaWVzCiBbUEFUQ0ggMTEvMTIgdjJd
IGRvY3M6IGlvY3RsLW51bWJlcjogdXBkYXRlIHBsYXRmb3JtIGVudHJpZXMKIFtQQVRDSCAxMi8x
MiB2Ml0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgRFJNIGVudHJpZXMKCiBEb2N1bWVudGF0
aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdCB8ICAgOTEgKysrKysrKyst
LS0KIDEgZmlsZSBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCnYy
IGNoYW5nZXM6Ci0gYWRkcmVzcyBzYXNoaWtvIHJldmlldyBjb21tZW50cwotIGRyb3AgYWRkaXRp
b24gb2YgYXJjaC94ODYva3ZtL3g4Ni5jIChTZWFuIENocmlzdG9waGVyc29uKQotIGRyb3AgbW9k
ZXJhdGVkIG1haWxpbmcgbGlzdHMKdjMgY2hhbmdlczoKLSB1cGRhdGUgdGhlIHNjYXJsZXR0MiBz
b3VuZCBkcml2ZXIgaW9jdGwgcmFuZ2UgKHNhc2hpa28pCi0gcmViYXNlIGFsbCBwYXRjaGVzIGlu
IHRoZSBzZXJpZXMKCgpDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4KQ2M6IFNo
dWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+CkNjOiBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnCkNjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAa2VybmVsLm9yZz4KQ2M6IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+CkNjOiBKYXNvbiBHdW50aG9y
cGUgPGpnZ0BudmlkaWEuY29tPgpDYzogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNv
bT4KQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZwpDYzogSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBwZXJl
eC5jej4KQ2M6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5jb20+CkNjOiBsaW51eC1zb3VuZEB2
Z2VyLmtlcm5lbC5vcmcKQ2M6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KQ2M6IGxpbnV4
LWJsb2NrQHZnZXIua2VybmVsLm9yZwpDYzogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1h
bm4ub3JnPgpDYzogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+
CkNjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnCkNjOiBXaWxsZW0gZGUgQnJ1aWpu
IDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPgpDYzogSmFzb24gV2FuZyA8amFzb3dh
bmdpb0BnbWFpbC5jb20+CkNjOiBEYXZpZCBIZWlkZWxiZXJnIDxkYXZpZEBpeGl0LmN6PgpDYzog
b2UtbGludXgtbmZjQGxpc3RzLmxpbnV4LmRldgpDYzogQ2hhcyBXaWxsaWFtcyA8M2NoYXMzQGdt
YWlsLmNvbT4KQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0PgpDYzog
RXJpYyBEdW1hemV0IDxlZHVtYXpldEBrZXJuZWwub3JnPgpDYzogSmFrdWIgS2ljaW5za2kgPGt1
YmFAa2VybmVsLm9yZz4KQ2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4KQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4KQ2M6
IGxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogTVBULUZ1c2lvbkxpbnV4LnBkbEBicm9hZGNvbS5jb20KQ2M6ICJKYW1lcyBF
LkouIEJvdHRvbWxleSIgPEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+CkNj
OiAiTWFydGluIEsuIFBldGVyc2VuIiA8bWtwQGtlcm5lbC5vcmc+CkNjOiBsaW51eC1zY3NpQHZn
ZXIua2VybmVsLm9yZwpDYzogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNv
bT4KQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CkNjOiBWaWduZXNoIFJh
Z2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+CkNjOiBaaGloYW8gQ2hlbmcgPGNoZW5nemhpaGFv
MUBodWF3ZWkuY29tPgpDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcKQ2M6IE5laWxs
IEthcHJvbiA8bmthcHJvbkBnb29nbGUuY29tPgpDYzogQW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5
a252bEBnbWFpbC5jb20+CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPgpDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZwpDYzogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPgpDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBr
ZXJuZWwub3JnPgpDYzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCkNjOiBIYW5zIGRl
IEdvZWRlIDxoYW5zZ0BrZXJuZWwub3JnPgpDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4KQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4KQ2M6IEV1Z2VuaW8g
UMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgpDYzogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vh
bmpjQGdvb2dsZS5jb20+CkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpD
Yzoga3ZtQHZnZXIua2VybmVsLm9yZwpDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2
CkNjOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6PgpDYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5l
bC5vcmcKQ2M6ICJUaGVvZG9yZSBUcydvIiA8dHl0c29AbWl0LmVkdT4KQ2M6IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnCkNjOiBNaWtlIE1hcnNoYWxsIDxodWJjYXBAb21uaWJvbmQuY29tPgpD
YzogZGV2ZWxAbGlzdHMub3JhbmdlZnMub3JnCkNjOiBQYXVsbyBBbGNhbnRhcmEgPHBjQG1hbmd1
ZWJpdC5vcmc+CkNjOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpDYzogbGlu
dXgtY2lmc0B2Z2VyLmtlcm5lbC5vcmcKQ2M6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5v
cmc+CkNjOiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+CkNjOiBsaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApDYzogRmxvcmlhbiBGYWluZWxsaSA8Zmxvcmlhbi5mYWluZWxs
aUBicm9hZGNvbS5jb20+CkNjOiBCcm9hZGNvbSBpbnRlcm5hbCBrZXJuZWwgcmV2aWV3IGxpc3Qg
PGJjbS1rZXJuZWwtZmVlZGJhY2stbGlzdEBicm9hZGNvbS5jb20+CkNjOiBUenVuZy1CaSBTaGlo
IDx0enVuZ2JpQGtlcm5lbC5vcmc+CkNjOiBCZW5zb24gTGV1bmcgPGJsZXVuZ0BjaHJvbWl1bS5v
cmc+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPgpDYzogU2ltb25hIFZldHRl
ciA8c2ltb25hQGZmd2xsLmNoPgpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKQ2M6IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+
CkNjOiBKb29uYXMgTGFodGluZW4gPGpvb25hcy5sYWh0aW5lbkBsaW51eC5pbnRlbC5jb20+CkNj
OiBSb2RyaWdvIFZpdmkgPHJvZHJpZ28udml2aUBpbnRlbC5jb20+CkNjOiBUdnJ0a28gVXJzdWxp
biA8dHVyc3VsaW5AdXJzdWxpbi5uZXQ+CkNjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4KQ2M6IFRob21h
cyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4KQ2M6IGludGVs
LXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
