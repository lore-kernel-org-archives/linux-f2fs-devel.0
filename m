Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD22606A884
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WLd6be1T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JMRrQbGd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A9NcPSKL;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LwYuYLj+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TV9D/xVA1AI3C+99LipCrga/PlXMRJIaO7ol4kAWrPE=; b=WLd6be1TPz+GGxuPSCVD0LmBLd
	hVVvvNhOF0yh8sXQhEB2ClamU5jl9w7zEw1FqBkiQnD2QvrIxtOGPsFqk829i/51tOsBlI6O4xQ+8
	VPzqdjsybr2Nc4GMko74gIpVyxJkvIbalJ2YR/UMNPIdI5jSQ6Wx5Y5oWxRcp871sHAc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSyfs-000000007Ia-0te6;
	Mon, 16 Nov 2026 15:31:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <3jxL7agYKAP4ykgtpimuumrk.ius@flex--seanjc.bounces.google.com>)
 id 1xSyfd-000000007HK-0oyu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:From:
 Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Julx96UTlwUpy/yEEb6XKUMDaihQ6nHqBxqUTRWWoDs=; b=JMRrQbGdyMQo0nZ7rIO2hZa6OT
 RPQ2+2CzIRpnFjlqtEfGp4wuWL48bxt1zN5dZUAzOP+ajPYHjsqjeXJF69MzH1yOub3HKF7GIuq9p
 Cyxume/MXMu02dtHHxC2UWxtXmQaKsrXX82IVxQAfawrdLkjlB/CGnR7ofiiUyI05L5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Julx96UTlwUpy/yEEb6XKUMDaihQ6nHqBxqUTRWWoDs=; b=A9NcPSKL7RxrtJQ+B3vwdcOvIO
 bYNmAl5fW7aT8sw1OF9t7VOgyrT2gFpUmIQgidCFasYGsaQvzQBz4MBCP6GryVCcFaDM5og6PIi1P
 0CvpeawQOGBPmfPfuw6SDhHGofZXMBDaKDxYE3w55Wmb97LRFIWqqw9xG6GsDRpVlikY=;
Received: from mail-qk1-f198.google.com ([209.85.222.198])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyfa-000000007Ps-2JJs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:31:01 +0000
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so1101349685a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794843052; x=1795447852;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Julx96UTlwUpy/yEEb6XKUMDaihQ6nHqBxqUTRWWoDs=;
 b=LwYuYLj+Ly4MoEVDG71wmMMEfRdmak1YEZge9VSFTjhUtcOQ5I0etJM2PfPYNUgLir
 JmJtGsDdKbAMDEzATJsG2AhCZLZSaDIYWJC5Co6jBtO1GPpyCLLoXRsfNm8tt/Otv4hl
 B8S10s0aSUBiCAQYGVmnnGcp5rgG/mY+qwAvtmSRb9QA8LxyiSRrD/ZPXtz0jBKN3QZ0
 2+zDRxZUfcIvQflMpsYi9aYLdj64fHVOs8v94GRnGKRSh6At2aKkGBUeVk3rH2Okh/i7
 QJKQB6CJGQMO4/yyXIfqX+V/X8qyUavexSK8SEwx0Y5U5hh6+BzJ/6BmtKztYrKMKm0k
 X2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794843052; x=1795447852;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Julx96UTlwUpy/yEEb6XKUMDaihQ6nHqBxqUTRWWoDs=;
 b=LT8BATels8gq18Wo+b+dxbkIX9Qyd14ciRpZEiT6yjebRIZ4caN+BzMJSN4HoaS1OL
 xuWJHsvX1Mu5O4TWsHenkaecIAq/vm/KYkir4Www/G2n3k0aTDwn6ngjp+KellT0noXl
 k7flPMdqfQT8tF6oNKpiKiY8AfRY8zRxHr7KYvznG2yz+7fey53lBVKTFEaPQ8WJx7yI
 F4tWwfg8i5A584RchvWsyBSH8Ms7d9JrTz42r+6aJyMvxzVea5AEgz7ASuwTmUbpM32y
 rT7ps5yLmTV6py8RlqNJaZetzCNS8fnxO+xf0F8y2LARoK2HaZXXNpLHAls07mqHgwwf
 8/jg==
X-Forwarded-Encrypted: i=1;
 AL+hErFvEScxzWVMTphnamiCn/vJzbu8GiR2LF5ZC0CXd+wWrxlvicvQmH8PIKSc14HSQFVq7rJyiL8IEQmRkZQw3kPS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9gplIz9e/xV6KlbQ5FhFj4cEcn3BpTWtscaoya6W9/+9nnemeI
 SOcYb+03osuKgKgba1txGQY6LLkPOJNo8zf7wRFlP44n+CYvkTCLL/V4gnSxcltJ5/ARIQMtcbs
 AzjmKeA==
X-Received: from pffm4-n2.prod.google.com
 ([2002:a05:6a00:c304:20b0:8a0:70d8:a2ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fc3:b0:89f:b166:bde6
 with SMTP id d2e1a72fcca58-8beb8cc8ad6mr9720424b3a.54.1794839183449; Mon, 16
 Nov 2026 06:26:23 -0800 (PST)
Date: Mon, 16 Nov 2026 06:26:22 -0800
In-Reply-To: <20261114202653.3113381-10-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-10-rdunlap@infradead.org>
Message-ID: <avsSjioXqbCOn834@seanjc-mac.roam.internal>
To: Randy Dunlap <rdunlap@infradead.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xSyfa-000000007Ps-2JJs
Subject: Re: [f2fs-dev] [PATCH 09/12] docs: ioctl-number: update
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
From: Sean Christopherson via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sean Christopherson <seanjc@google.com>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, Benson Leung <bleung@chromium.org>,
 David Airlie <airlied@gmail.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mike Marshall <hubcap@omnibond.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 linux-atm-general@lists.sourceforge.net, amd-gfx@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, MPT-FusionLinux.pdl@broadcom.com,
 Namjae Jeon <linkinjeon@kernel.org>, devel@lists.orangefs.org,
 Neill Kapron <nkapron@google.com>, Juergen Gross <jgross@suse.com>,
 Chas Williams <3chas3@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Marcel Holtmann <marcel@holtmann.org>, virtualization@lists.linux.dev,
 linux-sound@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 linux-block@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-rpi-kernel@lists.infradead.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, David Hildenbrand <david@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Andrey Konovalov <andreyknvl@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Matthew Brost <matthew.brost@intel.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, oe-linux-nfc@lists.linux.dev,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
 Takashi Iwai <tiwai@suse.com>, David Heidelberg <david@ixit.cz>,
 linux-f2fs-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCBOb3YgMTQsIDIwMjYsIFJhbmR5IER1bmxhcCB3cm90ZToKPiBVcGRhdGUgdGhlIGxp
c3Qgb2YgZmlsZXMgd2hlcmUgdmlydHVhbGl6YXRpb24gaW9jdGxzIGFyZSBkZWZpbmVkLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPgo+IC0t
LQo+IFtTaW5jZSBoYXZpbmcgbXVsdGlwbGUgbWFpbnRhaW5lcnMgdHJ5aW5nIHRvIG1lcmdlIHRo
ZXNlIHdvdWxkCj4gY2F1c2Ugc29tZSBjb25mbGljdHMsIGl0IHdvdWxkIGJlIG1vcmUgbWFuYWdl
YWJsZSBmb3IgSm9uIHRvCj4gdGFrZSBhbGwgb2YgdGhlc2UgdGhyb3VnaCB0aGUgZG9jcy1uZXh0
IHRyZWUuXQo+IAo+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pgo+IENjOiBT
aHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPgo+IENjOiBsaW51eC1kb2NAdmdl
ci5rZXJuZWwub3JnCj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KPiBDYzog
U3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPgo+IENjOiB4ZW4tZGV2
ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKPiBDYzogSGFucyBkZSBHb2VkZSA8aGFuc2dAa2VybmVs
Lm9yZz4KPiBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiBDYzogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPiBDYzogIk1pY2hhZWwgUy4g
VHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgo+IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ2lvQGdt
YWlsLmNvbT4KPiBDYzogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gQ2M6
IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPgo+IENjOiBQYW9sbyBCb256
aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgo+IENjOiBrdm1Admdlci5rZXJuZWwub3JnCj4gQ2M6
IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldgo+IAo+ICBEb2N1bWVudGF0aW9uL3VzZXJz
cGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdCB8ICAgIDYgKysrKysrCj4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiAKPiAtLS0gbGludXgtbmV4dC0yMDI2MTExMy5vcmln
L0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0Cj4gKysr
IGxpbnV4LW5leHQtMjAyNjExMTMvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lv
Y3RsLW51bWJlci5yc3QKPiBAQCAtMjAwLDYgKzIwMCw3IEBAIENvZGUgIFNlcSMgICAgSW5jbHVk
ZSBGaWxlCj4gICdNJyAgIDAxLTAzICBkcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfc2Fz
LmgKPiAgJ00nICAgMDAtMDMgIGRyaXZlcnMvdmlkZW8vZmJkZXYvbWI4NjJ4eC9tYjg2Mnh4ZmIu
aAo+ICAnTScgICAwMC0wRiAgZHJpdmVycy92aWRlby9mc2wtZGl1LWZiLmggICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQo+ICsnTScgICAwMS0wMyAgeGVuL2ludGVyZmFj
ZS94ZW4tbWNhLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQo+
ICAnTicgICAwMC0xRiAgZHJpdmVycy91c2Ivc2Nhbm5lci5oCj4gICdOJyAgIDQwLTdGICB1YXBp
L2xpbnV4L252bWVfaW9jdGwuaAo+ICAnTicgICA4MC04MyAgdWFwaS9saW51eC9udHN5bmMuaCBh
bmQgdWFwaS9saW51eC9udm1lX2lvY3RsLmggICAgICAgICAgIGNvbmZsaWN0IQo+IEBAIC0yMzks
NiArMjQwLDcgQEAgQ29kZSAgU2VxIyAgICBJbmNsdWRlIEZpbGUKPiAgJ1UnICAgNjQgICAgIGRy
aXZlcnMvdXNiL21pc2MvdXNidGVzdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25mbGljdCEKPiAgJ1YnICAgYWxsICAgIGxpbnV4L3Z0LmggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKPiAgJ1YnICAgYWxsICAgIGxpbnV4
L3ZpZGVvZGV2Mi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25m
bGljdCEKPiArJ1YnICAgMDAtMUYgIGxpbnV4L3Zib3hndWVzdC5oICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKPiAgJ1YnICAgQzAgICAgIGxpbnV4L2l2
dHZmYi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGlj
dCEKPiAgJ1YnICAgQzAgICAgIGxpbnV4L2l2dHYuaCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKPiAgJ1YnICAgQzAgICAgIG1lZGlhL3NpNDcx
My5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEK
PiBAQCAtMzU3LDYgKzM1OSw3IEBAIENvZGUgIFNlcSMgICAgSW5jbHVkZSBGaWxlCj4gICd8JyAg
IDgwLTlGICBzYW1wbGVzLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQW55IHNhbXBsZSBhbmQgZXhhbXBsZSBkcml2ZXJzCj4gIDB4ODAgIDAwLTFGICBs
aW51eC9mYi5oCj4gIDB4ODEgIDAwLTFGICBsaW51eC92ZHVzZS5oCj4gKyAgICAgICAgICAgICBk
cml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gIDB4ODkgIDAwLTA3ICBhc20tZ2Vu
ZXJpYy9zb2NraW9zLmgKPiAgMHg4OSAgMDYtMDcgIGxpbnV4L3NvY2tpb3MuaAo+ICAweDg5ICAw
Qi1ERiAgbGludXgvc29ja2lvcy5oCj4gQEAgLTM5OCw4ICs0MDEsMTEgQEAgQ29kZSAgU2VxIyAg
ICBJbmNsdWRlIEZpbGUKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8bWFpbHRvOmt2bUB2Z2VyLmtlcm5lbC5v
cmc+Cj4gIDB4QUUgIDQwLUZGICBsaW51eC9rdm0uaCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgS2VybmVsLWJhc2VkIFZpcnR1YWwgTWFjaGluZQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDxtYWlsdG86a3ZtQHZnZXIua2VybmVsLm9yZz4KPiArMHhBRSAgQzYgICAgIGFy
Y2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBY
ODYgS1ZNCgpJJ2QgcmF0aGVyIG9taXQgdGhpcyBlbnRyeS4gIDB4QUUgQzYgaXMgY292ZXJlZCBi
eSB0aGUgZW50cnkgYWJvdmUsIGFuZCB0aGUgaG9ycm9yCmluIGFyY2gveDg2L2t2bS94ODYuYyBp
cyBwdXJlbHkgYSAzMi1iaXQgY29tcGF0aWJpbGl0eSBhbGlhcyBmb3IgYW4gaW9jdGwgdGhhdCBp
cwpkZWZpbmVkIGluIGt2bS5oICh0aGUgc3RydWN0dXJlIHBheWxvYWQgZGVmaW5lcyBhbiBwb2lu
dGVyIGluc3RlYWQgb2YgYSBfX3U2NCkuCgpJZiBpdCdzIGEgc3RpY2tpbmcgcG9pbnQsIGUuZy4g
dGhpcyB3aWxsIHRyaXAgYXV0b21hdGVkIHRvb2xpbmcgb3ZlciBhbmQgb3ZlciwgdGhlbgpJIHZv
dGUgdG8gbW92ZSB0aGUgcmVsZXZhbnQgZGVmaW5pdGlvbnMgdG8gdWFwaSBoZWFkZXJzLCBlLmcu
CgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm0uaCBiL2FyY2gveDg2
L2luY2x1ZGUvdWFwaS9hc20va3ZtLmgKaW5kZXggMDBjZTI2NTM5MWUxLi5lMDJlZjdhMzlmN2Mg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtLmgKKysrIGIvYXJjaC94
ODYvaW5jbHVkZS91YXBpL2FzbS9rdm0uaApAQCAtMjMwLDYgKzIzMCwxOCBAQCBzdHJ1Y3Qga3Zt
X21zcl9maWx0ZXIgewogCXN0cnVjdCBrdm1fbXNyX2ZpbHRlcl9yYW5nZSByYW5nZXNbS1ZNX01T
Ul9GSUxURVJfTUFYX1JBTkdFU107CiB9OwoKK3N0cnVjdCBrdm1fbXNyX2ZpbHRlcl9yYW5nZV9j
b21wYXQgeworCV9fdTMyIGZsYWdzOworCV9fdTMyIG5tc3JzOworCV9fdTMyIGJhc2U7CisJX191
MzIgYml0bWFwOworfTsKKworc3RydWN0IGt2bV9tc3JfZmlsdGVyX2NvbXBhdCB7CisJX191MzIg
ZmxhZ3M7CisJc3RydWN0IGt2bV9tc3JfZmlsdGVyX3JhbmdlX2NvbXBhdCByYW5nZXNbS1ZNX01T
Ul9GSUxURVJfTUFYX1JBTkdFU107Cit9OworCiBzdHJ1Y3Qga3ZtX2NwdWlkX2VudHJ5IHsKIAlf
X3UzMiBmdW5jdGlvbjsKIAlfX3UzMiBlYXg7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2
LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggMDc3MWVmYWY5NGM4Li5lZjlmOTJjYmE1ODkg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMK
QEAgLTQyNjAsMjEgKzQyNjAsNiBAQCBpbnQga3ZtX3ZtX2lvY3RsX2VuYWJsZV9jYXAoc3RydWN0
IGt2bSAqa3ZtLAogfQoKICNpZmRlZiBDT05GSUdfS1ZNX0NPTVBBVAotLyogZm9yIEtWTV9YODZf
U0VUX01TUl9GSUxURVIgKi8KLXN0cnVjdCBrdm1fbXNyX2ZpbHRlcl9yYW5nZV9jb21wYXQgewot
CV9fdTMyIGZsYWdzOwotCV9fdTMyIG5tc3JzOwotCV9fdTMyIGJhc2U7Ci0JX191MzIgYml0bWFw
OwotfTsKLQotc3RydWN0IGt2bV9tc3JfZmlsdGVyX2NvbXBhdCB7Ci0JX191MzIgZmxhZ3M7Ci0J
c3RydWN0IGt2bV9tc3JfZmlsdGVyX3JhbmdlX2NvbXBhdCByYW5nZXNbS1ZNX01TUl9GSUxURVJf
TUFYX1JBTkdFU107Ci19OwotCi0jZGVmaW5lIEtWTV9YODZfU0VUX01TUl9GSUxURVJfQ09NUEFU
IF9JT1coS1ZNSU8sIDB4YzYsIHN0cnVjdCBrdm1fbXNyX2ZpbHRlcl9jb21wYXQpCi0KIGxvbmcg
a3ZtX2FyY2hfdm1fY29tcGF0X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQg
aW9jdGwsCiAJCQkgICAgICB1bnNpZ25lZCBsb25nIGFyZykKIHsKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdWFwaS9saW51eC9rdm0uaCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaAppbmRleCA4ZGZm
MmZjMTk3MmUuLjU0ZGJkYWJkMGU5YiAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2
bS5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaApAQCAtMTQ3Nyw2ICsxNDc3LDcgQEAg
c3RydWN0IGt2bV9lbmNfcmVnaW9uIHsKCiAvKiBBdmFpbGFibGUgd2l0aCBLVk1fQ0FQX1g4Nl9N
U1JfRklMVEVSICovCiAjZGVmaW5lIEtWTV9YODZfU0VUX01TUl9GSUxURVIJX0lPVyhLVk1JTywg
IDB4YzYsIHN0cnVjdCBrdm1fbXNyX2ZpbHRlcikKKyNkZWZpbmUgS1ZNX1g4Nl9TRVRfTVNSX0ZJ
TFRFUl9DT01QQVQgX0lPVyhLVk1JTywgMHhjNiwgc3RydWN0IGt2bV9tc3JfZmlsdGVyX2NvbXBh
dCkKCiAvKiBBdmFpbGFibGUgd2l0aCBLVk1fQ0FQX0RJUlRZX0xPR19SSU5HICovCiAjZGVmaW5l
IEtWTV9SRVNFVF9ESVJUWV9SSU5HUwkJX0lPKEtWTUlPLCAweGM3KQoKPiAgMHhBRSAgMjAtM0Yg
IGxpbnV4L25pdHJvX2VuY2xhdmVzLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBOaXRybyBFbmNsYXZlcwo+ICAweEFGICAwMC0xRiAgbGludXgvZnNsX2h5cGVydmlzb3IuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZyZWVzY2FsZSBoeXBlcnZpc29yCj4g
KzB4QUYgIDAwLThGICBsaW51eC92aG9zdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uZmxpY3QhCj4gKzB4QUYgIDMxLTMyICBkcml2ZXJzL3Zob3N0L3Rl
c3QuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCj4gIDB4
QjAgIGFsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUkFUSU8gZGV2aWNlcyBpbiBkZXZlbG9wbWVudDoKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8bWFpbHRvOnZnb0ByYXRpby5kZT4KPiAgMHhCMSAgMDAtMUYgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQUFBvWAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
