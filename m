Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F4606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AZR0h7vf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e16EnO5w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UNHzxJFS;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VThYQCTK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=bRA0l9lHEQ4wmK6aKe9VksuhWu0/tE7H4KbVNNXmTpc=; b=AZR0h7vfKDy5eYiURDyqFqp9pZ
	vL5v44DLt3X9EpsNwnqQYiv+VGhqFPVfqpVK1dfwkRZkt9WJWpAb3NbHATrWvXOatcU7BDdc3+1rG
	cKy/blfzPO3p0FtkXXQey+hX/vDYJ18BiaHGdVeOiFvHM7aPvr63YPQ15hqIwuuW5dD8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT55S-000000000hs-1rFJ;
	Mon, 16 Nov 2026 22:22:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xT54x-000000000fO-1ihI;
 Mon, 16 Nov 2026 22:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXL/fDhspKdov1Fv9R2cAMXBgedf/LG6cvi6/7Jo65c=; b=e16EnO5wE++wYDqqCWLMRO2Vo4
 Vd7Npx0AKwkvjNE+zjwOQ51+oBj1A/vrrJqk+WsCvi65nzKIWpKE/3cykj7jkJaCjFjxcQLDhN/je
 c0X3vyhpiJU7GUiUWBQUeZvz2Nc7tEjXTIXKPljgvxR4fsu2N3cRpanf11417l6hkZJU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXL/fDhspKdov1Fv9R2cAMXBgedf/LG6cvi6/7Jo65c=; b=UNHzxJFSyjEPR3/LhqCsded0a9
 SwhiO08I8TTX38iv+lDU0u/CxsROZbATfDELnsg/eWW54sBmvNNjYZCd26ILfJzkCX423AjZdghBZ
 HYFIBHzBpCz2kypUkaSL9uO7FlXdHn2KhJafaIlheK/0WCwDPztbZhsZMHbA2vpzdyh8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT54v-000000002Y4-3H76; Mon, 16 Nov 2026 22:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=BXL/fDhspKdov1Fv9R2cAMXBgedf/LG6cvi6/7Jo65c=; b=VThYQCTK0+YExl2+ZO7Tuknnrf
 6kyowduHpBQVpfb7n1tSXedtpFNkU4jMk3jIu9Hkgh6YTzADUmrCxgKLrv9IjmY8LwM/wyAWTvTDD
 e/sSQp4UOb5tjuY3MxqRJvsxNsiNknNcq0RGaoSG8yJ8wUiQCVmAZBGlVLxfcZjyr94azpjr9IOnd
 AWdz3ni0uhKjLd3gREkk+4rC3s26NSvhlfY2UUaXgX8uIh0R2U5pwjQCQjGVYJS1A2bXWMI8l49wW
 l2fyCL1r+D2yYRXbpcd1pUH4Eqp+JWnGEwFXHp6SFfFUzbYmxjvOpOGIgf4yt8A3Gek5Rph3JughC
 ysCNVjJg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xT54Y-000000042c2-2GpG; Mon, 16 Nov 2026 22:21:10 +0000
Message-ID: <65bab646-fbf6-4da0-b833-2314d568a845@infradead.org>
Date: Mon, 16 Nov 2026 14:21:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Christopherson <seanjc@google.com>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-10-rdunlap@infradead.org>
 <avsSjioXqbCOn834@seanjc-mac.roam.internal>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <avsSjioXqbCOn834@seanjc-mac.roam.internal>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xT54v-000000002Y4-3H76
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
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CgpPbiAxMS8xNi8yNiA2OjI2IEFNLCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOgo+IE9uIFNh
dCwgTm92IDE0LCAyMDI2LCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4+IFVwZGF0ZSB0aGUgbGlzdCBv
ZiBmaWxlcyB3aGVyZSB2aXJ0dWFsaXphdGlvbiBpb2N0bHMgYXJlIGRlZmluZWQuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPgo+PiAtLS0K
Pj4gW1NpbmNlIGhhdmluZyBtdWx0aXBsZSBtYWludGFpbmVycyB0cnlpbmcgdG8gbWVyZ2UgdGhl
c2Ugd291bGQKPj4gY2F1c2Ugc29tZSBjb25mbGljdHMsIGl0IHdvdWxkIGJlIG1vcmUgbWFuYWdl
YWJsZSBmb3IgSm9uIHRvCj4+IHRha2UgYWxsIG9mIHRoZXNlIHRocm91Z2ggdGhlIGRvY3MtbmV4
dCB0cmVlLl0KPj4KPj4gQ2M6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+Cj4+IENj
OiBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPgo+PiBDYzogbGludXgtZG9j
QHZnZXIua2VybmVsLm9yZwo+PiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+
PiBDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPgo+PiBDYzog
eGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCj4+IENjOiBIYW5zIGRlIEdvZWRlIDxoYW5z
Z0BrZXJuZWwub3JnPgo+PiBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPj4gQ2M6
IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4+IENjOiAi
TWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+Cj4+IENjOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ2lvQGdtYWlsLmNvbT4KPj4gQ2M6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRo
YXQuY29tPgo+PiBDYzogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+Cj4+
IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgo+PiBDYzoga3ZtQHZnZXIu
a2VybmVsLm9yZwo+PiBDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2Cj4+Cj4+ICBE
b2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdCB8ICAgIDYg
KysrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4+Cj4+IC0tLSBsaW51
eC1uZXh0LTIwMjYxMTEzLm9yaWcvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lv
Y3RsLW51bWJlci5yc3QKPj4gKysrIGxpbnV4LW5leHQtMjAyNjExMTMvRG9jdW1lbnRhdGlvbi91
c2Vyc3BhY2UtYXBpL2lvY3RsL2lvY3RsLW51bWJlci5yc3QKPj4gQEAgLTIwMCw2ICsyMDAsNyBA
QCBDb2RlICBTZXEjICAgIEluY2x1ZGUgRmlsZQo+PiAgJ00nICAgMDEtMDMgIGRyaXZlcnMvc2Nz
aS9tZWdhcmFpZC9tZWdhcmFpZF9zYXMuaAo+PiAgJ00nICAgMDAtMDMgIGRyaXZlcnMvdmlkZW8v
ZmJkZXYvbWI4NjJ4eC9tYjg2Mnh4ZmIuaAo+PiAgJ00nICAgMDAtMEYgIGRyaXZlcnMvdmlkZW8v
ZnNsLWRpdS1mYi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKPj4g
KydNJyAgIDAxLTAzICB4ZW4vaW50ZXJmYWNlL3hlbi1tY2EuaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uZmxpY3QhCj4+ICAnTicgICAwMC0xRiAgZHJpdmVycy91c2Ivc2Nh
bm5lci5oCj4+ICAnTicgICA0MC03RiAgdWFwaS9saW51eC9udm1lX2lvY3RsLmgKPj4gICdOJyAg
IDgwLTgzICB1YXBpL2xpbnV4L250c3luYy5oIGFuZCB1YXBpL2xpbnV4L252bWVfaW9jdGwuaCAg
ICAgICAgICAgY29uZmxpY3QhCj4+IEBAIC0yMzksNiArMjQwLDcgQEAgQ29kZSAgU2VxIyAgICBJ
bmNsdWRlIEZpbGUKPj4gICdVJyAgIDY0ICAgICBkcml2ZXJzL3VzYi9taXNjL3VzYnRlc3QuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCj4+ICAnVicgICBhbGwgICAg
bGludXgvdnQuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbmZsaWN0IQo+PiAgJ1YnICAgYWxsICAgIGxpbnV4L3ZpZGVvZGV2Mi5oICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mbGljdCEKPj4gKydWJyAgIDAwLTFGICBs
aW51eC92Ym94Z3Vlc3QuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29uZmxpY3QhCj4+ICAnVicgICBDMCAgICAgbGludXgvaXZ0dmZiLmggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZsaWN0IQo+PiAgJ1YnICAgQzAgICAgIGxp
bnV4L2l2dHYuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25mbGljdCEKPj4gICdWJyAgIEMwICAgICBtZWRpYS9zaTQ3MTMuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCj4+IEBAIC0zNTcsNiArMzU5LDcg
QEAgQ29kZSAgU2VxIyAgICBJbmNsdWRlIEZpbGUKPj4gICd8JyAgIDgwLTlGICBzYW1wbGVzLyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQW55IHNhbXBs
ZSBhbmQgZXhhbXBsZSBkcml2ZXJzCj4+ICAweDgwICAwMC0xRiAgbGludXgvZmIuaAo+PiAgMHg4
MSAgMDAtMUYgIGxpbnV4L3ZkdXNlLmgKPj4gKyAgICAgICAgICAgICBkcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jCj4+ICAweDg5ICAwMC0wNyAgYXNtLWdlbmVyaWMvc29ja2lvcy5o
Cj4+ICAweDg5ICAwNi0wNyAgbGludXgvc29ja2lvcy5oCj4+ICAweDg5ICAwQi1ERiAgbGludXgv
c29ja2lvcy5oCj4+IEBAIC0zOTgsOCArNDAxLDExIEBAIENvZGUgIFNlcSMgICAgSW5jbHVkZSBG
aWxlCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDxtYWlsdG86a3ZtQHZnZXIua2VybmVsLm9yZz4KPj4gIDB4
QUUgIDQwLUZGICBsaW51eC9rdm0uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgS2VybmVsLWJhc2VkIFZpcnR1YWwgTWFjaGluZQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8bWFpbHRvOmt2bUB2Z2VyLmtlcm5lbC5vcmc+Cj4+ICsweEFFICBDNiAgICAgYXJjaC94ODYv
a3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFg4NiBLVk0K
PiAKPiBJJ2QgcmF0aGVyIG9taXQgdGhpcyBlbnRyeS4gIDB4QUUgQzYgaXMgY292ZXJlZCBieSB0
aGUgZW50cnkgYWJvdmUsIGFuZCB0aGUgaG9ycm9yCj4gaW4gYXJjaC94ODYva3ZtL3g4Ni5jIGlz
IHB1cmVseSBhIDMyLWJpdCBjb21wYXRpYmlsaXR5IGFsaWFzIGZvciBhbiBpb2N0bCB0aGF0IGlz
Cj4gZGVmaW5lZCBpbiBrdm0uaCAodGhlIHN0cnVjdHVyZSBwYXlsb2FkIGRlZmluZXMgYW4gcG9p
bnRlciBpbnN0ZWFkIG9mIGEgX191NjQpLgoKT0suCgo+IElmIGl0J3MgYSBzdGlja2luZyBwb2lu
dCwgZS5nLiB0aGlzIHdpbGwgdHJpcCBhdXRvbWF0ZWQgdG9vbGluZyBvdmVyIGFuZCBvdmVyLCB0
aGVuCj4gSSB2b3RlIHRvIG1vdmUgdGhlIHJlbGV2YW50IGRlZmluaXRpb25zIHRvIHVhcGkgaGVh
ZGVycywgZS5nLgoKSSBkb24ndCBrbm93IG9mIGFueXRoaW5nIGxpa2UgdGhhdC4KCi0tIAp+UmFu
ZHkKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
