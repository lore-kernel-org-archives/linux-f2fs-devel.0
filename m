Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6D606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VV+f+936;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cOxBdBSr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BddoomKW;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ds41J1Y9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=8qK2MFzQtjU+DTgCpqqyM3otmwR5GNyMd0UNoOF3dQE=; b=VV+f+936Cb4TTtm6ya2iaX80Uq
	+TuU4PCUQgeBvK6e9WzWCDb9sQk1lx92t0ToUkNUrpDkrL7BqAXMihJjonkp7R/ZCaDOS59PMKWwF
	nKhmYOu9dft66N2sCaeblN7Qr1Yz/PB3Eanjh2tjzkTbfzZTAdgYAaO7MtVhB9g/duR0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTuoZ-000000006mf-3kh7;
	Thu, 19 Nov 2026 05:36:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xTuoY-000000006lr-0Fx9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zaTgPA2ioXn8bej2IOl4WB8n/Qq2lc7VcV2P19XHg1w=; b=cOxBdBSrbCV4xVoEOFho8v0vaw
 OxGNcxtzvZi+l4y9J8XY0st4vcHOxo8Qx7GbjqL498jEL2W0noF2u3kkjEYr9WGyvTPMGrD+v2jyH
 eZW+RQijYKVvvjBgdHDgpcD20FS84rIK/sEhxEjWIzl3WITlhcazSMlhsobcrqmQEaqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zaTgPA2ioXn8bej2IOl4WB8n/Qq2lc7VcV2P19XHg1w=; b=BddoomKWgriuUpv1FrTwncJw0R
 NgvUQn1aNbfz/oq5ZDisx8nIFMHosrdSS4ST+TObF/q/M8VTj+Zya4N+CSfJ3xhLnkAu7c5kKGWZz
 LdD5tYDU6qu04wKCFSja+Mf5eFcRLo6DoslolxcKV1biLMkEiBvuveJQv9tQA73yhh7g=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTuoX-000000003CO-1Q9v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 05:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=zaTgPA2ioXn8bej2IOl4WB8n/Qq2lc7VcV2P19XHg1w=; b=Ds41J1Y94G5phu/yjrxMx4KYs0
 fd3xEflO7koDu9fjKtT0RrT6JXtuJE3ZGa/b7tv14vHbrsGtLa9cBI8rWCSO9JxiwR/EzHbJ4YyWH
 8z4Lfo2FA3XkU/tifbzr7MvY35pYR9hWGECyuQjjenBjpJMzarej8UBGlp6AB5Cl5B9wZl2ct2hlr
 yP4GZiRBHQWZ0GJWk0TzDbpYf/RtAtr+lznKLzz5QUj256D7TrUxLU7g8UYM2iIVWUk5ZdrVUV65b
 sNHHYVEKZzdr+lQMzW/6WDGqL5WcSfqNg5neQakCI513B5k5l1uBxRkTPLb31FzLHo0nl7cBnoUgi
 7Q0sWVXw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTuoJ-0000000Aufu-00YY; Thu, 19 Nov 2026 05:35:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 21:35:13 -0800
Message-ID: <20261119053514.255348-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119053514.255348-1-rdunlap@infradead.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTuoX-000000003CO-1Q9v
Subject: [f2fs-dev] [PATCH v2 12/12] docs: ioctl-number: update DRM entries
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
OiBubyBjaGFuZ2UKCltTaW5jZSBoYXZpbmcgbXVsdGlwbGUgbWFpbnRhaW5lcnMgdHJ5aW5nIHRv
IG1lcmdlIHRoZXNlIHdvdWxkCmNhdXNlIHNvbWUgY29uZmxpY3RzLCBpdCB3b3VsZCBiZSBtb3Jl
IG1hbmFnZWFibGUgZm9yIEpvbiB0bwp0YWtlIGFsbCBvZiB0aGVzZSB0aHJvdWdoIHRoZSBkb2Nz
LW5leHQgdHJlZS5dCgpDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4KQ2M6IFNo
dWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+CkNjOiBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnCkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPgpDYzogU2ltb25h
IFZldHRlciA8c2ltb25hQGZmd2xsLmNoPgpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKQ2M6IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBsaW51eC5pbnRl
bC5jb20+CkNjOiBKb29uYXMgTGFodGluZW4gPGpvb25hcy5sYWh0aW5lbkBsaW51eC5pbnRlbC5j
b20+CkNjOiBSb2RyaWdvIFZpdmkgPHJvZHJpZ28udml2aUBpbnRlbC5jb20+CkNjOiBUdnJ0a28g
VXJzdWxpbiA8dHVyc3VsaW5AdXJzdWxpbi5uZXQ+CkNjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4KQ2M6
IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4KQ2M6
IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwoKIERvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0IHwgICAgNSArKysrLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGxpbnV4LW5leHQtMjAyNjExMTYu
b3JpZy9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdAor
KysgbGludXgtbmV4dC0yMDI2MTExNi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwv
aW9jdGwtbnVtYmVyLnJzdApAQCAtOTgsNiArOTgsNyBAQCBDb2RlICBTZXEjICAgIEluY2x1ZGUg
RmlsZQogMHgxYiAgYWxsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJbmZpbmlCYW5kIFN1YnN5c3RlbQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
aHR0cDovL2luZmluaWJhbmQuc291cmNlZm9yZ2UubmV0Lz4KIDB4MjAgIGFsbCAgICBkcml2ZXJz
L2Nkcm9tL2NtMjA2LmgKKzB4MjAgIDAwLTAxICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdW1yLmgKIDB4MjIgIGFsbCAgICBzY3NpL3NnLmgKIDB4M0UgIDAwLTBGICBsaW51eC9j
b3VudGVyLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPG1haWx0
bzpsaW51eC1paW9Admdlci5rZXJuZWwub3JnPgogJyEnICAgMDAtMUYgIHVhcGkvbGludXgvc2Vj
Y29tcC5oCkBAIC0yNjgsNyArMjY5LDcgQEAgQ29kZSAgU2VxIyAgICBJbmNsdWRlIEZpbGUKICdj
JyAgIDA4ICAgICBkcml2ZXJzL3Njc2kvY2guYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uZmxpY3QhCiAnYycgICA4MC05RiAgYXJjaC9zMzkwL2luY2x1ZGUvYXNt
L2Noc2MuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQogJ2MnICAgQTAt
QUYgIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oIGNvbmZsaWN0IQotJ2QnICAgMDAtRkYgIGxp
bnV4L2NoYXIvZHJtL2RybS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25mbGljdCEKKydkJyAgIDAwLUZGICBkcm0vZHJtLmggICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCiAnZCcgICAwMi00MCAgcGNtY2lhL2Rz
LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0
IQogJ2QnICAgRjAtRkYgIGxpbnV4L2RpZ2kxLmgKICdlJyAgIGFsbCAgICBsaW51eC9kaWdpMS5o
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCkBA
IC0yOTIsNiArMjkzLDggQEAgQ29kZSAgU2VxIyAgICBJbmNsdWRlIEZpbGUKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPG1haWx0bzp6YXBtYW5AaW50ZXJsYW4ubmV0PgogJ2gnICAgMDAtMUYgIGxpbnV4L2hwZXQu
aCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEK
ICdoJyAgIDgwLThGICBmcy9oZnNwbHVzL2lvY3RsLmMKKydpJyAgIDAwLTAyICBkcm0vaTkxNV9k
cm0uaAorJ2knICAgMDAtMDQgIGRybS94ZV9kcm0uaAogJ2knICAgMDAtM0YgIGxpbnV4L2kyby1k
ZXYuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEK
ICdpJyAgIDBCLTFGICBsaW51eC9pcG1pLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uZmxpY3QhCiAnaScgICA4MC04RiAgbGludXgvaThrLmgKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRl
dmVsCg==
