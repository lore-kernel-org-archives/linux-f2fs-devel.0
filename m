Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F64606A68D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q5IZ2Vmj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LxjMfgqC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FyUbS7B5;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OQ10UQlo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=dcd83H62V65K0sCr3fHoruxwu/oP2oolpl516S2d/c8=; b=Q5IZ2Vmji0HSBm7pTiLlhNw/Ju
	BZ4UMky1guViabGW7MCbZ+Q45NzmZGyuuIy6Z3UO1llZ5L4N7UhzVGzsSaVHbowEAPC6XhmP0yfZi
	Z/bsmELVN4ThxKpZfXYNi8H/WV12i3hNnMRTw2/M8DkKlamxKhxm0Qc6fxz49fohJ2wc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW6H6-000000005Wx-0IB6;
	Wed, 25 Nov 2026 06:14:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xW6H5-000000005Wj-00Mx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:14:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nH1JDKUpxZKr2E7xywv7sSC/lG5A4nxPxWDHndTmH+U=; b=LxjMfgqCSYER6cz96UTjCscWgb
 2TLKnY+Ue9HnklB8wqHWTfrOfRu1LTFtucPtQvuqKi9u28ICfYlCeWhziezh24rARi5sg7Tys5ulb
 d1m0WkqLNAbEQvazORA/DILRXYD+v/v00y8D9vGlFVwQM/k5NcVe0qrXCrjztnvVhkzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nH1JDKUpxZKr2E7xywv7sSC/lG5A4nxPxWDHndTmH+U=; b=FyUbS7B51EIORo8pdteCIhqUBB
 EdnSoJB9hhoMbEahEe8V38ICCTmtDUT+BRqXamSf7jQZjc9xQwHenrJcsegN5K0geSYgCP7f+w+Vd
 aQmRTUMuwCB6eZ4yX6GjTfZHqsMaVmtfQJkum/lROowIxXh4k3fburZp0zdrgf2yptJM=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW6H3-000000007TF-1oT0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=nH1JDKUpxZKr2E7xywv7sSC/lG5A4nxPxWDHndTmH+U=; b=OQ10UQlojOOElMejsET63HIbzZ
 3DHzvbtYIGqi3qtZVmlnOiTGbSwjJaXCrsDgpHInm2eUGr8Xc79IeDQYDrtJVitNB0FwJZCPO4B8q
 +iOBeVWlbGzBejGX44u6FBx6jMlOzwnzs0/RPybD92JWe+ZEhd2F0VZXPfoSXXKlqmHkpJj3BYeff
 PI7xG81lPzaQFyumhKdnS4tNxkr8IW9Cdx3c7fbkK4m5X/Zh5Rgxrc0VYPw9ZDhRuFltHqM60uFWP
 hZDBs8jxgJq594XvPuA6d95qyJlYfVavjeq76w/EreE8GdBtyeqVTX0Sp6D1XhKyU0S94iu4liry5
 Ut1LqIcw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xW6Gh-00000008Wvh-0GYM; Wed, 25 Nov 2026 06:14:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 22:13:39 -0800
Message-ID: <20261125061340.3402300-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125061340.3402300-1-rdunlap@infradead.org>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xW6H3-000000007TF-1oT0
Subject: [f2fs-dev] [PATCH v3 12/12] docs: ioctl-number: update DRM entries
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

VXBkYXRlIHRoZSBsaXN0IG9mIGZpbGVzIHdoZXJlIERSTSBpb2N0bHMgYXJlIGRlZmluZWQuCgpT
aWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KLS0tCnYy
OiBubyBjaGFuZ2UKdjM6IHJlYmFzZQoKW1NpbmNlIGhhdmluZyBtdWx0aXBsZSBtYWludGFpbmVy
cyB0cnlpbmcgdG8gbWVyZ2UgdGhlc2Ugd291bGQKY2F1c2Ugc29tZSBjb25mbGljdHMsIGl0IHdv
dWxkIGJlIG1vcmUgbWFuYWdlYWJsZSBmb3IgSm9uIHRvCnRha2UgYWxsIG9mIHRoZXNlIHRocm91
Z2ggdGhlIGRvY3MtbmV4dCB0cmVlLl0KCkNjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24u
bmV0PgpDYzogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4KQ2M6IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmcKQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+
CkNjOiBTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+CkNjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxh
QGxpbnV4LmludGVsLmNvbT4KQ2M6IEpvb25hcyBMYWh0aW5lbiA8am9vbmFzLmxhaHRpbmVuQGxp
bnV4LmludGVsLmNvbT4KQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4K
Q2M6IFR2cnRrbyBVcnN1bGluIDx0dXJzdWxpbkB1cnN1bGluLm5ldD4KQ2M6IGludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50
ZWwuY29tPgpDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50
ZWwuY29tPgpDYzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCgogRG9jdW1lbnRhdGlv
bi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lvY3RsLW51bWJlci5yc3QgfCAgICA1ICsrKystCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gbGludXgtbmV4
dC0yMDI2MTEyMy5vcmlnL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1u
dW1iZXIucnN0CisrKyBsaW51eC1uZXh0LTIwMjYxMTIzL0RvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0CkBAIC05OCw2ICs5OCw3IEBAIENvZGUgIFNlcSMg
ICAgSW5jbHVkZSBGaWxlCiAweDFiICBhbGwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEluZmluaUJhbmQgU3Vic3lzdGVtCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDxodHRwOi8vaW5maW5pYmFuZC5zb3VyY2Vmb3JnZS5uZXQvPgogMHgyMCAgYWxs
ICAgIGRyaXZlcnMvY2Ryb20vY20yMDYuaAorMHgyMCAgMDAtMDEgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91bXIuaAogMHgyMiAgYWxsICAgIHNjc2kvc2cuaAogMHgzRSAgMDAt
MEYgIGxpbnV4L2NvdW50ZXIuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8bWFpbHRvOmxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+CiAnIScgICAwMC0xRiAgdWFw
aS9saW51eC9zZWNjb21wLmgKQEAgLTI2OCw3ICsyNjksNyBAQCBDb2RlICBTZXEjICAgIEluY2x1
ZGUgRmlsZQogJ2MnICAgMDggICAgIGRyaXZlcnMvc2NzaS9jaC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKICdjJyAgIDgwLTlGICBhcmNoL3MzOTAv
aW5jbHVkZS9hc20vY2hzYy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3Qh
CiAnYycgICBBMC1BRiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmggY29uZmxpY3QhCi0nZCcg
ICAwMC1GRiAgbGludXgvY2hhci9kcm0vZHJtLmggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbmZsaWN0IQorJ2QnICAgMDAtRkYgIGRybS9kcm0uaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKICdkJyAgIDAyLTQw
ICBwY21jaWEvZHMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uZmxpY3QhCiAnZCcgICBGMC1GRiAgbGludXgvZGlnaTEuaAogJ2UnICAgYWxsICAgIGxp
bnV4L2RpZ2kxLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25mbGljdCEKQEAgLTI5Miw2ICsyOTMsOCBAQCBDb2RlICBTZXEjICAgIEluY2x1ZGUgRmlsZQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA8bWFpbHRvOnphcG1hbkBpbnRlcmxhbi5uZXQ+CiAnaCcgICAwMC0xRiAg
bGludXgvaHBldC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbmZsaWN0IQogJ2gnICAgODAtOEYgIGZzL2hmc3BsdXMvaW9jdGwuYworJ2knICAgMDAtMDIg
IGRybS9pOTE1X2RybS5oCisnaScgICAwMC0wNCAgZHJtL3hlX2RybS5oCiAnaScgICAwMC0zRiAg
bGludXgvaTJvLWRldi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbmZsaWN0IQogJ2knICAgMEItMUYgIGxpbnV4L2lwbWkuaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKICdpJyAgIDgwLThGICBsaW51eC9p
OGsuaAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
