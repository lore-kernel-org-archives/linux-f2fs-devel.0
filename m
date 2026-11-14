Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE2606FAD6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dQPJzWRF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FNPECacM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ql3Ym/JO;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=URTxLvs8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=yqokaH4MPIUkJoL8pEk54lbh6SP+5iDPGhoRHXzeatM=; b=dQPJzWRFvGzwPWqHXmHXjo5ss4
	ReKH6ROpYfoP6gHCbyEK7oguDcb+mdiEy5H4aGoZG4udvSigBNWNQmT3f9rLANj37afbEE1zEwRbK
	VtHYUb+zXQz5WrPglhvx+rHWqUU04R+TJ9o3riFnyQNvieYVgi1AiBiLBgjlJO51e8ME=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSKLt-000000000iL-2li0;
	Sat, 14 Nov 2026 20:27:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xSKLW-000000000gc-0eem;
 Sat, 14 Nov 2026 20:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUoI6BfFH1sB0+FMEHOL0bU6KfXMRPa7Wq1sLElSuu8=; b=FNPECacMRC+OvuiAtrJqjpzM/s
 4SC0A9ovPxHRw67Al+hNA15ECZanZfl6RLLZbSVrxYi3gtNLLO4yMdRoCZlTw+CaKSja0t4vfgaZ8
 hXHn2G7mRbGVdSS6XAvwQKfQdB2h6SEl3ujEge3gsFoq0RvHq9F9GVsXIMVoO+B8EMTc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUoI6BfFH1sB0+FMEHOL0bU6KfXMRPa7Wq1sLElSuu8=; b=Ql3Ym/JOQygZCuoW6DiDoLNTRX
 guyRgdJb+bRzgdgPqEbCUvRYvqOlSBZnrjQdglO1zrweq95EXHa9PLKZkQchQfHDyyiArWuNEqF11
 Mtfeer07SgIKx+O6OpdzY859RjC9lKZcpkbb4jvYSpZjuP4oQLbsgc0LYkjoZwFy7uyg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSKLT-000000005ca-2y3b; Sat, 14 Nov 2026 20:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=jUoI6BfFH1sB0+FMEHOL0bU6KfXMRPa7Wq1sLElSuu8=; b=URTxLvs8s42zIeIRrKz8C6wtsy
 abmbm9qXp3jOcsGAYH+pKr3RJ497JX3Sk6817p0QAhQG/rKzLG+v4FcRs4ORGLq+M0q7u3BfuXAdw
 l6tZH8HZo6NNAGvkcfu/jWfS2ccRSv08zndHkheLkJGJ9BZE41hQpKP614JLBybA8TfI50vC1kBVf
 fqdsu8BNwUYSTtYCoe2DMkVzVLNSqWikyGMVDouYC4NVgTb8URX0mOshBMLufByQAwDlKKmqNvYeU
 D931VlcKiTqNxXT4D0DqdghI9GaWOGO01Wj3VpY2SrnpJZHlsQymu/nwKbhgtvWTV+vGgjLLjTlnJ
 IlrwuQZw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xSKKt-0000000Giga-2fmk; Sat, 14 Nov 2026 20:26:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 12:26:38 -0800
Message-ID: <20261114202653.3113381-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSKLT-000000005ca-2y3b
Subject: [f2fs-dev] [PATCH 00/12] docs: ioctl-number: update entries
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
eHQgdHJlZS5dCgogW1BBVENIIDAxLzEyXSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0ZSBNTSBl
bnRyaWVzCiBbUEFUQ0ggMDIvMTJdIGRvY3M6IGlvY3RsLW51bWJlcjogdXBkYXRlIHNvdW5kIGVu
dHJpZXMKIFtQQVRDSCAwMy8xMl0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgYmxvY2sgZW50
cmllcwogW1BBVENIIDA0LzEyXSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0ZSBuZXR3b3JraW5n
IGVudHJpZXMKIFtQQVRDSCAwNS8xMl0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgdmlkZW8v
ZmJkZXYgZW50cmllcwogW1BBVENIIDA2LzEyXSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0ZSBT
Q1NJIGVudHJpZXMKIFtQQVRDSCAwNy8xMl0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgTVRE
IGVudHJpZXMKIFtQQVRDSCAwOC8xMl0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgVVNCIGVu
dHJpZXMKIFtQQVRDSCAwOS8xMl0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgdmlydHVhbGl6
YXRpb24gZW50cmllcwogW1BBVENIIDEwLzEyXSBkb2NzOiBpb2N0bC1udW1iZXI6IHVwZGF0ZSBG
UyBlbnRyaWVzCiBbUEFUQ0ggMTEvMTJdIGRvY3M6IGlvY3RsLW51bWJlcjogdXBkYXRlIHBsYXRm
b3JtIGVudHJpZXMKIFtQQVRDSCAxMi8xMl0gZG9jczogaW9jdGwtbnVtYmVyOiB1cGRhdGUgRFJN
IGVudHJpZXMKCiBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVy
LnJzdCB8ICAgOTEgKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCsp
LCAxOSBkZWxldGlvbnMoLSkKCkNjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PgpD
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
czNAZ21haWwuY29tPgpDYzogbGludXgtYXRtLWdlbmVyYWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
CkNjOiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KQ2M6IEVyaWMgRHVt
YXpldCA8ZWR1bWF6ZXRAa2VybmVsLm9yZz4KQ2M6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+CkNjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+CkNjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnCkNjOiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+CkNjOiBsaW51eC1m
YmRldkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IE1QVC1GdXNpb25MaW51eC5wZGxAYnJvYWRjb20uY29tCkNjOiAiSmFtZXMgRS5KLiBCb3R0
b21sZXkiIDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPgpDYzogIk1hcnRp
biBLLiBQZXRlcnNlbiIgPG1rcEBrZXJuZWwub3JnPgpDYzogbGludXgtc2NzaUB2Z2VyLmtlcm5l
bC5vcmcKQ2M6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+CkNjOiBS
aWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpDYzogVmlnbmVzaCBSYWdoYXZlbmRy
YSA8dmlnbmVzaHJAdGkuY29tPgpDYzogWmhpaGFvIENoZW5nIDxjaGVuZ3poaWhhbzFAaHVhd2Vp
LmNvbT4KQ2M6IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBOZWlsbCBLYXByb24g
PG5rYXByb25AZ29vZ2xlLmNvbT4KQ2M6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJleWtudmxAZ21h
aWwuY29tPgpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4KQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4KQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9y
Zz4KQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwpDYzogSGFucyBkZSBHb2VkZSA8
aGFuc2dAa2VybmVsLm9yZz4KQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+CkNjOiAi
TWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+CkNjOiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQ2M6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPgpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KQ2M6IGt2bUB2
Z2VyLmtlcm5lbC5vcmcKQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldgpDYzogSmFu
IEthcmEgPGphY2tAc3VzZS5jej4KQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnCkNj
OiAiVGhlb2RvcmUgVHMnbyIgPHR5dHNvQG1pdC5lZHU+CkNjOiBsaW51eC1leHQ0QHZnZXIua2Vy
bmVsLm9yZwpDYzogTWlrZSBNYXJzaGFsbCA8aHViY2FwQG9tbmlib25kLmNvbT4KQ2M6IGRldmVs
QGxpc3RzLm9yYW5nZWZzLm9yZwpDYzogUGF1bG8gQWxjYW50YXJhIDxwY0BtYW5ndWViaXQub3Jn
PgpDYzogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4KQ2M6IGxpbnV4LWNpZnNA
dmdlci5rZXJuZWwub3JnCkNjOiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgpDYzog
Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgpDYzogbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRj
b20uY29tPgpDYzogQnJvYWRjb20gaW50ZXJuYWwga2VybmVsIHJldmlldyBsaXN0IDxiY20ta2Vy
bmVsLWZlZWRiYWNrLWxpc3RAYnJvYWRjb20uY29tPgpDYzogbGludXgtcnBpLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
Q2M6IFR6dW5nLUJpIFNoaWggPHR6dW5nYmlAa2VybmVsLm9yZz4KQ2M6IEJlbnNvbiBMZXVuZyA8
YmxldW5nQGNocm9taXVtLm9yZz4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+
CkNjOiBTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+CkNjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxh
QGxpbnV4LmludGVsLmNvbT4KQ2M6IEpvb25hcyBMYWh0aW5lbiA8am9vbmFzLmxhaHRpbmVuQGxp
bnV4LmludGVsLmNvbT4KQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4K
Q2M6IFR2cnRrbyBVcnN1bGluIDx0dXJzdWxpbkB1cnN1bGluLm5ldD4KQ2M6IGludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50
ZWwuY29tPgpDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50
ZWwuY29tPgpDYzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
