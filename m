Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951D606A6B6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NHIveEUP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T7ZX9FGV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ORmXB6Ld;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mgdlg0/0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=SjH/YRjBMNqAr/7Frc98ujw+YbGl5sIs+GQB/JVVcXc=; b=NHIveEUP8z0771WxN1xCXX8LO9
	SYlxJK0j9pbAs52IFrMYYdkifEod/QGq2UqSizuBUJYB7+DC70wRRcuF1CUmw6FoeGO4913S6BMgK
	1xmS/GEWqNksj7iEFg6AZXsvFJ1uXjWoCTIVMamBlY+i2Rsts13o2EyWx7p8jnguuyQo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW6H0-000000006fa-2FRQ;
	Wed, 25 Nov 2026 06:14:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xW6Gx-000000006ez-49G4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjBc4ifTPecXL/WS/5jRX16xGScyR8p+iOgEL82NW6g=; b=T7ZX9FGV2mHJxMFKp4Mh2E3Vbn
 Zs1u08dukOrIKwSGwVsnoPojeRCxkrwXyEvuVHqX8Cyf7t3h7brHLMkGKoPaLxET/ZteDMbnuDjtg
 PlJErD+EJKbXlG0kV30DpqG2M2hFJ7TJ8qQyIg5hwEVNxmF3IPU3nw2kMLm7ITDjDJGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjBc4ifTPecXL/WS/5jRX16xGScyR8p+iOgEL82NW6g=; b=ORmXB6LdMqAFMK8QPL19y3jYSp
 ixIeigN5FtRGkffTCXjjZkPUaxeE2F14+nPEdCowisH0969ZIHXgzdy2rrh7d+QSuMuW37T5Qzi0V
 5aN2/nuKBDnZldYGbc5w0QTvUm2bYxC91jsp45mLde+0c/g07KtDXl5PTE9ifxWnVa58=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW6Gx-000000007Q7-1qlF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=RjBc4ifTPecXL/WS/5jRX16xGScyR8p+iOgEL82NW6g=; b=Mgdlg0/0XSQjJ+dbSaAYTFfsa4
 jIjxnNXFhICrq6W7ftIa+TIE86KDOEjUDyK2cEZS4G5oUvv6wT2NqOP421irvhcz4PbRlcas6Oek4
 l04G9EUR+6lOX3Jayr2U2sSBtCCNHkP1n+3PQPaQGwEw/1rIYipgOcNZEx2aqEtpYURknBByGxkqD
 +1irAhRtvZoVNuopSWs9s3oNUPF38vJ8gXUOZgeu0Hwk54++nUWGcP/VByRYvqRpKYywd7T2TW8EJ
 T+jvEdVi23iEjnzjxZQuYh8vKJZCfbXTwMyr25vKCuGSvKrKMlUn5BVbe0GYKO/Qn7nuahYqNPikU
 wbdGOsKA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xW6Gb-00000008Wvh-0C4P; Wed, 25 Nov 2026 06:14:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 22:13:36 -0800
Message-ID: <20261125061340.3402300-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125061340.3402300-1-rdunlap@infradead.org>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xW6Gx-000000007Q7-1qlF
Subject: [f2fs-dev] [PATCH v3 09/12] docs: ioctl-number: update
 virtualization entries
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VXBkYXRlIHRoZSBsaXN0IG9mIGZpbGVzIHdoZXJlIHZpcnR1YWxpemF0aW9uIGlvY3RscyBhcmUg
ZGVmaW5lZC4KClNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQu
b3JnPgotLS0KdjI6IGRyb3AgMHhBRSwgQzYsIGFyY2gveDg2L2t2bS94ODYuYyAoY292ZXJlZCBi
eSBsaW5lIGFib3ZlOwogICAgU2VhbiBDaHJpc3RvcGhlcnNvbikKdjM6IHJlYmFzZQoKW1NpbmNl
IGhhdmluZyBtdWx0aXBsZSBtYWludGFpbmVycyB0cnlpbmcgdG8gbWVyZ2UgdGhlc2Ugd291bGQK
Y2F1c2Ugc29tZSBjb25mbGljdHMsIGl0IHdvdWxkIGJlIG1vcmUgbWFuYWdlYWJsZSBmb3IgSm9u
IHRvCnRha2UgYWxsIG9mIHRoZXNlIHRocm91Z2ggdGhlIGRvY3MtbmV4dCB0cmVlLl0KCkNjOiBK
b25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PgpDYzogU2h1YWggS2hhbiA8c2toYW5AbGlu
dXhmb3VuZGF0aW9uLm9yZz4KQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcKQ2M6IEp1ZXJn
ZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJl
bGxpbmlAa2VybmVsLm9yZz4KQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwpDYzog
SGFucyBkZSBHb2VkZSA8aGFuc2dAa2VybmVsLm9yZz4KQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgpDYzogSmFzb24g
V2FuZyA8amFzb3dhbmdpb0BnbWFpbC5jb20+CkNjOiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4KQ2M6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPgpD
YzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KQ2M6IGt2bUB2Z2VyLmtlcm5l
bC5vcmcKQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldgoKIERvY3VtZW50YXRpb24v
dXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0IHwgICAgNSArKysrKwogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKLS0tIGxpbnV4LW5leHQtMjAyNjExMjMub3JpZy9E
b2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdAorKysgbGlu
dXgtbmV4dC0yMDI2MTEyMy9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwt
bnVtYmVyLnJzdApAQCAtMTk4LDYgKzE5OCw3IEBAIENvZGUgIFNlcSMgICAgSW5jbHVkZSBGaWxl
CiAnTScgICAwMS0wMyAgZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX3Nhcy5oCiAnTScg
ICAwMC0wMyAgZHJpdmVycy92aWRlby9mYmRldi9tYjg2Mnh4L21iODYyeHhmYi5oCiAnTScgICAw
MC0wRiAgZHJpdmVycy92aWRlby9mc2wtZGl1LWZiLmggICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbmZsaWN0IQorJ00nICAgMDEtMDMgIHhlbi9pbnRlcmZhY2UveGVuLW1jYS5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKICdOJyAgIDAwLTFGICBk
cml2ZXJzL3VzYi9zY2FubmVyLmgKICdOJyAgIDQwLTdGICB1YXBpL2xpbnV4L252bWVfaW9jdGwu
aAogJ04nICAgODAtODMgIHVhcGkvbGludXgvbnRzeW5jLmggYW5kIHVhcGkvbGludXgvbnZtZV9p
b2N0bC5oICAgICAgICAgICBjb25mbGljdCEKQEAgLTIzOCw2ICsyMzksNyBAQCBDb2RlICBTZXEj
ICAgIEluY2x1ZGUgRmlsZQogJ1UnICAgNjQgICAgIGRyaXZlcnMvdXNiL21pc2MvdXNidGVzdC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKICdWJyAgIGFsbCAgICBs
aW51eC92dC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29uZmxpY3QhCiAnVicgICBhbGwgICAgbGludXgvdmlkZW9kZXYyLmggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQorJ1YnICAgMDAtMUYgIGxpbnV4L3Zi
b3hndWVzdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGlj
dCEKICdWJyAgIEMwICAgICBsaW51eC9pdnR2ZmIuaCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCiAnVicgICBDMCAgICAgbGludXgvaXZ0di5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQogJ1Yn
ICAgQzAgICAgIG1lZGlhL3NpNDcxMy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25mbGljdCEKQEAgLTM1Niw2ICszNTgsNyBAQCBDb2RlICBTZXEjICAgIElu
Y2x1ZGUgRmlsZQogJ3wnICAgODAtOUYgIHNhbXBsZXMvICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBbnkgc2FtcGxlIGFuZCBleGFtcGxlIGRyaXZlcnMK
IDB4ODAgIDAwLTFGICBsaW51eC9mYi5oCiAweDgxICAwMC0xRiAgbGludXgvdmR1c2UuaAorICAg
ICAgICAgICAgIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKIDB4ODkgIDAwLTA3
ICBhc20tZ2VuZXJpYy9zb2NraW9zLmgKIDB4ODkgIDA2LTA3ICBsaW51eC9zb2NraW9zLmgKIDB4
ODkgIDBCLURGICBsaW51eC9zb2NraW9zLmgKQEAgLTM5OSw2ICs0MDIsOCBAQCBDb2RlICBTZXEj
ICAgIEluY2x1ZGUgRmlsZQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8bWFpbHRvOmt2bUB2Z2VyLmtlcm5lbC5v
cmc+CiAweEFFICAyMC0zRiAgbGludXgvbml0cm9fZW5jbGF2ZXMuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5pdHJvIEVuY2xhdmVzCiAweEFGICAwMC0xRiAgbGludXgvZnNs
X2h5cGVydmlzb3IuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZyZWVzY2Fs
ZSBoeXBlcnZpc29yCisweEFGICAwMC04RiAgbGludXgvdmhvc3QuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQorMHhBRiAgMzEtMzIgIGRyaXZl
cnMvdmhvc3QvdGVzdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25m
bGljdCEKIDB4QjAgIGFsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUkFUSU8gZGV2aWNlcyBpbiBkZXZlbG9wbWVudDoKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPG1haWx0bzp2Z29AcmF0aW8uZGU+CiAweEIxICAwMC0xRiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBQUG9YCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
