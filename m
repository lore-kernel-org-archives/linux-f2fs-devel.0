Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7B607359E
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gZWdVk5O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GfyfXOwL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mFO7r8S5;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K+RxW3IU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ApJCxlYxcr832IEs+cvSHt55PLkumavkaZmfZ8qN3wQ=; b=gZWdVk5OaksCPDMXG6rAKPGeSu
	/LsxnfXxuEKba3f7AY9Kc1e4jMxFwVXn8JZgiCYUcuV/up32kwZvc4vtnSvb7PBFDdBrzozqoNrgz
	dYhbz4VsnBRZQjufLL7OcafL4YyGKYD6cWPbtm4zWg5mR0iiiQOXazV40frv3i4BCN6A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSKLp-000000003mb-02NS;
	Sat, 14 Nov 2026 20:27:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xSKLY-000000003iv-0sym;
 Sat, 14 Nov 2026 20:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g4Lr1iIWwCQDLrfv4xinJtkANuRZUZ3Hye3ay62BdDM=; b=GfyfXOwLJdHwky2QGytGfE+vxT
 mOUcSNdE+4LnhBvOMxFW/WZhKvPcY9M//VDvYPGcnDL+KQJRiN7e7DDLCV6xzQ45QzhMG4xHRCPf8
 t3Dn4R2KaAksF2Tx0zkBK2MeDRcfDcqDmY6ptIx0tCNuaFX+AJQzGdaQN/CM5zNkjwOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g4Lr1iIWwCQDLrfv4xinJtkANuRZUZ3Hye3ay62BdDM=; b=mFO7r8S5mwUwtM9WmsMPUtJcEB
 6oqA4US+6jvGUlj6YfntvqVYLxE2+L5fW4Mzy2DbHfuRu/SJxLUK9UtqdenqTrnE6R/MPqZj2/x31
 51ZrWWHvjyBgwlR9XegH8skkTV4loS2IbQZB+23rM+W8HxIaXhBWOFmbFIICw4AHQwRc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSKLX-000000005EZ-2Zic; Sat, 14 Nov 2026 20:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=g4Lr1iIWwCQDLrfv4xinJtkANuRZUZ3Hye3ay62BdDM=; b=K+RxW3IUjPLut10UJdZN3BFbmh
 pNxgVj59+6O/xkEPsB1hqiX0K6qZJW5/M8/WqEV1J7uMnx4KuEIEFt0PDhNvNcwHr2uGYrrUYIwcE
 gtcxC7ZIsLuo69Ei00wEPYqF7uh+iWtquvhO3gwZQqnj+BOkE3qYRmomz1FB4DYyLM5e+4m7yTRmn
 VucLIkmDKfNlqGfpBae0bAvW/bzkfaOJqgckrrJ4zF1mbFGvbDxX3S9VlDpAP5qmgkUnrmxxb4L0D
 9Zo2mI2kpwS22kcR/S14ACNaGrbtHanSEoj1F3pzRF7XLKfrnQnw7bMTvvwNNW+4Bb7gQaOVbRqc7
 vcfk00zQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xSKLD-0000000Giga-0Wfi; Sat, 14 Nov 2026 20:27:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 12:26:47 -0800
Message-ID: <20261114202653.3113381-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114202653.3113381-1-rdunlap@infradead.org>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSKLX-000000005EZ-2Zic
Subject: [f2fs-dev] [PATCH 09/12] docs: ioctl-number: update virtualization
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VXBkYXRlIHRoZSBsaXN0IG9mIGZpbGVzIHdoZXJlIHZpcnR1YWxpemF0aW9uIGlvY3RscyBhcmUg
ZGVmaW5lZC4KClNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQu
b3JnPgotLS0KW1NpbmNlIGhhdmluZyBtdWx0aXBsZSBtYWludGFpbmVycyB0cnlpbmcgdG8gbWVy
Z2UgdGhlc2Ugd291bGQKY2F1c2Ugc29tZSBjb25mbGljdHMsIGl0IHdvdWxkIGJlIG1vcmUgbWFu
YWdlYWJsZSBmb3IgSm9uIHRvCnRha2UgYWxsIG9mIHRoZXNlIHRocm91Z2ggdGhlIGRvY3MtbmV4
dCB0cmVlLl0KCkNjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PgpDYzogU2h1YWgg
S2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4KQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmcKQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KQ2M6IFN0ZWZhbm8gU3Rh
YmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4KQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5w
cm9qZWN0Lm9yZwpDYzogSGFucyBkZSBHb2VkZSA8aGFuc2dAa2VybmVsLm9yZz4KQ2M6IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPgpDYzogSmFzb24gV2FuZyA8amFzb3dhbmdpb0BnbWFpbC5jb20+CkNjOiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQ2M6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5q
Y0Bnb29nbGUuY29tPgpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KQ2M6
IGt2bUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldgoK
IERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0IHwgICAg
NiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCi0tLSBsaW51eC1uZXh0
LTIwMjYxMTEzLm9yaWcvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lvY3RsLW51
bWJlci5yc3QKKysrIGxpbnV4LW5leHQtMjAyNjExMTMvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2Ut
YXBpL2lvY3RsL2lvY3RsLW51bWJlci5yc3QKQEAgLTIwMCw2ICsyMDAsNyBAQCBDb2RlICBTZXEj
ICAgIEluY2x1ZGUgRmlsZQogJ00nICAgMDEtMDMgIGRyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdh
cmFpZF9zYXMuaAogJ00nICAgMDAtMDMgIGRyaXZlcnMvdmlkZW8vZmJkZXYvbWI4NjJ4eC9tYjg2
Mnh4ZmIuaAogJ00nICAgMDAtMEYgIGRyaXZlcnMvdmlkZW8vZnNsLWRpdS1mYi5oICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKKydNJyAgIDAxLTAzICB4ZW4vaW50ZXJm
YWNlL3hlbi1tY2EuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3Qh
CiAnTicgICAwMC0xRiAgZHJpdmVycy91c2Ivc2Nhbm5lci5oCiAnTicgICA0MC03RiAgdWFwaS9s
aW51eC9udm1lX2lvY3RsLmgKICdOJyAgIDgwLTgzICB1YXBpL2xpbnV4L250c3luYy5oIGFuZCB1
YXBpL2xpbnV4L252bWVfaW9jdGwuaCAgICAgICAgICAgY29uZmxpY3QhCkBAIC0yMzksNiArMjQw
LDcgQEAgQ29kZSAgU2VxIyAgICBJbmNsdWRlIEZpbGUKICdVJyAgIDY0ICAgICBkcml2ZXJzL3Vz
Yi9taXNjL3VzYnRlc3QuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3Qh
CiAnVicgICBhbGwgICAgbGludXgvdnQuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbmZsaWN0IQogJ1YnICAgYWxsICAgIGxpbnV4L3ZpZGVvZGV2Mi5o
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKKydWJyAg
IDAwLTFGICBsaW51eC92Ym94Z3Vlc3QuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uZmxpY3QhCiAnVicgICBDMCAgICAgbGludXgvaXZ0dmZiLmggICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQogJ1YnICAgQzAgICAg
IGxpbnV4L2l2dHYuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25mbGljdCEKICdWJyAgIEMwICAgICBtZWRpYS9zaTQ3MTMuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCkBAIC0zNTcsNiArMzU5LDcgQEAg
Q29kZSAgU2VxIyAgICBJbmNsdWRlIEZpbGUKICd8JyAgIDgwLTlGICBzYW1wbGVzLyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQW55IHNhbXBsZSBhbmQg
ZXhhbXBsZSBkcml2ZXJzCiAweDgwICAwMC0xRiAgbGludXgvZmIuaAogMHg4MSAgMDAtMUYgIGxp
bnV4L3ZkdXNlLmgKKyAgICAgICAgICAgICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jCiAweDg5ICAwMC0wNyAgYXNtLWdlbmVyaWMvc29ja2lvcy5oCiAweDg5ICAwNi0wNyAgbGlu
dXgvc29ja2lvcy5oCiAweDg5ICAwQi1ERiAgbGludXgvc29ja2lvcy5oCkBAIC0zOTgsOCArNDAx
LDExIEBAIENvZGUgIFNlcSMgICAgSW5jbHVkZSBGaWxlCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxtYWlsdG86
a3ZtQHZnZXIua2VybmVsLm9yZz4KIDB4QUUgIDQwLUZGICBsaW51eC9rdm0uaCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgS2VybmVsLWJhc2VkIFZpcnR1YWwg
TWFjaGluZQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8bWFpbHRvOmt2bUB2Z2VyLmtlcm5lbC5vcmc+CisweEFF
ICBDNiAgICAgYXJjaC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFg4NiBLVk0KIDB4QUUgIDIwLTNGICBsaW51eC9uaXRyb19lbmNsYXZlcy5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTml0cm8gRW5jbGF2ZXMKIDB4QUYgIDAw
LTFGICBsaW51eC9mc2xfaHlwZXJ2aXNvci5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRnJlZXNjYWxlIGh5cGVydmlzb3IKKzB4QUYgIDAwLThGICBsaW51eC92aG9zdC5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCisweEFG
ICAzMS0zMiAgZHJpdmVycy92aG9zdC90ZXN0LmggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbmZsaWN0IQogMHhCMCAgYWxsICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSQVRJTyBkZXZpY2VzIGluIGRldmVs
b3BtZW50OgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8bWFpbHRvOnZnb0ByYXRpby5kZT4KIDB4QjEgIDAwLTFG
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUFBQb1gKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCg==
