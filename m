Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4772606A6CB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N6LGrcWF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WPOez3P+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dfGUB7SF;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dl/IZb7Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=DF6hhI9hauO54UUZb/w+ckSdEP3bdReNWYH2VAhFsVE=; b=N6LGrcWFS6D3KgaCUWYgJVSAhf
	NSqnIkvbmPAVGhnbtAbDDY8Qi/epnQ+7aqigIvGaehbv7bZSkYGJ5kt53em/5x3IzVpR0kZ/VWlgn
	PGDn1hej9CU4uUkLKZO+E3Z6M2DA/4GQGZzn45zqZcJU79NWi1krxQqlicFEHA+KMXvU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTuoN-0000000067d-2VWW;
	Thu, 19 Nov 2026 05:35:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xTuoH-0000000067T-3ksF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wI8CfhdJeg04jWEb1L4OD1/9oeLf+JacfAtLza0pzdI=; b=WPOez3P+nZdPoCU6TZRErAjQh1
 Iryo/H//HNtm/7xpFZia3GFPiVem/DR92PWKo7r+qRSztYNQs6atz9vpwWP7lUeOXoZ2Fz94TU2Dj
 Ok23hlfZuOcsUBAp6nbhLyrSGQsQiEeZCnG3qp4hgDhsNKAKlkfsCpwUEDt7V1b7Exso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wI8CfhdJeg04jWEb1L4OD1/9oeLf+JacfAtLza0pzdI=; b=dfGUB7SFTtyGQO5LA84tmf/guq
 pn9UYWmfUtICdPV1whnENLoa2Exr44eUgsXghorGi87D44tLHHSl4mTKjJa48+BULmB/Yg4lQSXb2
 08oGZ3aGRXHgpzmxSPqCQaCLZZoBlhdqHH8RBEivO4B0PZWFZRJSJlydM6mDDazmetPI=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTuoF-0000000048a-03hH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=wI8CfhdJeg04jWEb1L4OD1/9oeLf+JacfAtLza0pzdI=; b=Dl/IZb7ZirAh4LO2ebf/j6bdQJ
 u/4ZQxUclJ2CI5g988zCrigVZ1hcfxds6UT4gZnz+vh/lZ0RL7QWAEVSZWiGy+9RwmxWO5wx0ZDs6
 kPW8F2oxgjkoGe72bbIdZi1w7XQICElbyp/YFGOUx6u8+zbEWXrHMGCPrRpuV6CQHf85fwvAUdsVT
 LVivE2X9BfGwEOvFwKjIvDqZoNzIHMDLP3fKUyqP1Lvw5bG74GAojv+3SBV1aOoswkbf+RLtCyN9m
 Eho4rd1Q5Yiwc2ujQXqfD0A4FNzXday04jFRsdcGQ5G3SlDriiaO+79gGOqMOjRL8GgzEM+EV34Ts
 w/ifmTnw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTunn-0000000Aufu-0t5B; Thu, 19 Nov 2026 05:35:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 21:35:01 -0800
Message-ID: <20261119053514.255348-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTuoF-0000000048a-03hH
Subject: [f2fs-dev] [PATCH v2 00/12 RESEND] docs: ioctl-number: update
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
ZXJhdGVkIG1haWxpbmcgbGlzdHMKCihSRVNFTkQ6IEkgdHJpZWQgdXNpbmcgLS1zdXBwcmVzcy1j
Yz1hdXRvIGJ1dCB0aGVuIG5vIG9uZSB3YXMgQ2MtZWQuCkkgd2FudGVkIHRvIHVzZSBvbmx5IHRo
ZSBleHBsaWNpdCBDYzpzIGluIGVhY2ggZW1haWwgaW5zdGVhZApvZiBzZW5kaW5nIGFsbCBwYXRj
aGVzIHRvIGV2ZXJ5b25lLikKCkNjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PgpD
YzogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4KQ2M6IGxpbnV4LWRvY0B2
Z2VyLmtlcm5lbC5vcmcKQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBrZXJuZWwub3JnPgpD
YzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KQ2M6IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+CkNjOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0Budmlk
aWEuY29tPgpDYzogbGludXgtbW1Aa3ZhY2sub3JnCkNjOiBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4
QHBlcmV4LmN6PgpDYzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmNvbT4KQ2M6IGxpbnV4LXNv
dW5kQHZnZXIua2VybmVsLm9yZwpDYzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgpDYzog
bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnCkNjOiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBo
b2x0bWFubi5vcmc+CkNjOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWls
LmNvbT4KQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcKQ2M6IFdpbGxlbSBkZSBC
cnVpam4gPHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+CkNjOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ2lvQGdtYWlsLmNvbT4KQ2M6IERhdmlkIEhlaWRlbGJlcmcgPGRhdmlkQGl4aXQuY3o+
CkNjOiBvZS1saW51eC1uZmNAbGlzdHMubGludXguZGV2CkNjOiBDaGFzIFdpbGxpYW1zIDwzY2hh
czNAZ21haWwuY29tPgpDYzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
CkNjOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGtlcm5lbC5vcmc+CkNjOiBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPgpDYzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPgpD
YzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZwpDYzogSGVsZ2UgRGVsbGVyIDxkZWxsZXJAZ214LmRl
PgpDYzogbGludXgtZmJkZXZAdmdlci5rZXJuZWwub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCkNjOiBNUFQtRnVzaW9uTGludXgucGRsQGJyb2FkY29tLmNvbQpDYzogIkph
bWVzIEUuSi4gQm90dG9tbGV5IiA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNv
bT4KQ2M6ICJNYXJ0aW4gSy4gUGV0ZXJzZW4iIDxta3BAa2VybmVsLm9yZz4KQ2M6IGxpbnV4LXNj
c2lAdmdlci5rZXJuZWwub3JnCkNjOiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tPgpDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KQ2M6IFZpZ25l
c2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4KQ2M6IFpoaWhhbyBDaGVuZyA8Y2hlbmd6
aGloYW8xQGh1YXdlaS5jb20+CkNjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzog
TmVpbGwgS2Fwcm9uIDxua2Fwcm9uQGdvb2dsZS5jb20+CkNjOiBBbmRyZXkgS29ub3ZhbG92IDxh
bmRyZXlrbnZsQGdtYWlsLmNvbT4KQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+CkNjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnCkNjOiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+CkNjOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxs
aW5pQGtlcm5lbC5vcmc+CkNjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKQ2M6IEhh
bnMgZGUgR29lZGUgPGhhbnNnQGtlcm5lbC5vcmc+CkNjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgpDYzogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CkNjOiBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuamNAZ29vZ2xlLmNvbT4KQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+CkNjOiBrdm1Admdlci5rZXJuZWwub3JnCkNjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC5kZXYKQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+CkNjOiBsaW51eC1mc2RldmVsQHZnZXIu
a2VybmVsLm9yZwpDYzogIlRoZW9kb3JlIFRzJ28iIDx0eXRzb0BtaXQuZWR1PgpDYzogbGludXgt
ZXh0NEB2Z2VyLmtlcm5lbC5vcmcKQ2M6IE1pa2UgTWFyc2hhbGwgPGh1YmNhcEBvbW5pYm9uZC5j
b20+CkNjOiBkZXZlbEBsaXN0cy5vcmFuZ2Vmcy5vcmcKQ2M6IFBhdWxvIEFsY2FudGFyYSA8cGNA
bWFuZ3VlYml0Lm9yZz4KQ2M6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+CkNj
OiBsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZwpDYzogSmFlZ2V1ayBLaW0gPGphZWdldWtAa2Vy
bmVsLm9yZz4KQ2M6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KQ2M6IGxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0CkNjOiBGbG9yaWFuIEZhaW5lbGxpIDxmbG9yaWFuLmZh
aW5lbGxpQGJyb2FkY29tLmNvbT4KQ2M6IEJyb2FkY29tIGludGVybmFsIGtlcm5lbCByZXZpZXcg
bGlzdCA8YmNtLWtlcm5lbC1mZWVkYmFjay1saXN0QGJyb2FkY29tLmNvbT4KQ2M6IFR6dW5nLUJp
IFNoaWggPHR6dW5nYmlAa2VybmVsLm9yZz4KQ2M6IEJlbnNvbiBMZXVuZyA8YmxldW5nQGNocm9t
aXVtLm9yZz4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+CkNjOiBTaW1vbmEg
VmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4LmludGVs
LmNvbT4KQ2M6IEpvb25hcyBMYWh0aW5lbiA8am9vbmFzLmxhaHRpbmVuQGxpbnV4LmludGVsLmNv
bT4KQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4KQ2M6IFR2cnRrbyBV
cnN1bGluIDx0dXJzdWxpbkB1cnN1bGluLm5ldD4KQ2M6IGludGVsLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPgpDYzog
VGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPgpDYzog
aW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
