Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94933606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Nov 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YOn1qd+q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RbVc7pdY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lv+0Y5WN;
	dkim=neutral header.d=sakamocchi.jp header.i=@sakamocchi.jp header.a=rsa-sha256 header.s=fm3 header.b=pjuVmr/L;
	dkim=neutral header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=syy3aDEc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=umM/UlaTxLrLRuPQUS+ipjvgYy8p+E2BVAr5u3j8hlQ=; b=YOn1qd+q73rh5nB8TE+5l9fSox
	cLBsXmwcQIDVOaTp2HLhqyhy/XKn6caXrn406zIdsRx7qW8jkZvv6ZUkKbIy6oRuXX1mIdbTL+Mwb
	3Y4Q3bvj00YCHnePg4vUqdUYfzxGHaXxeIz4jQK+1lO2kOJJ9n6kl0sFRh3Rv7GAIpmA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSOup-000000004Zi-4BnG;
	Sun, 15 Nov 2026 01:20:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <o-takashi@sakamocchi.jp>) id 1xSOuo-000000004ZZ-0ZS5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 01:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QIES4zNTDxRjCnYHiHcWq6p6uX7fK/EWYh7I/zXroHQ=; b=RbVc7pdYesf35fYXV/CiUN+SDb
 4ainmTVOFWlqeZaFzsmbaMPAGyvfetkP2C93JHQfh7s9TQk9MjTb/3GmPmvxOkwxBy/6wUgjp9UZf
 p8yMHDriE8u8z04P6GTvwhyAq2NqXyq7riHq0OQUkf2I4cGb9+LKwssEUJEaTGoqYE6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QIES4zNTDxRjCnYHiHcWq6p6uX7fK/EWYh7I/zXroHQ=; b=lv+0Y5WN0ZOKtpkj50kHx9PhZI
 2e7fChwpWIOI5dtXqPxlwRjc3NpD7bhU454+PkiptAS+6hAumlLDHLpe/cXR3rwARlgd+vHIdt5Qj
 H7lTU9VFcO3yqSyOX5dJU47M8uw15apD0h1yK4/OcO5rzHuVv7VG6DsoQ7ke8V6GigFo=;
Received: from flow-a8-smtp.messagingengine.com ([103.168.172.143])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSOul-000000001XI-2t8c
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 01:20:18 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id CAB1C1381D6B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 20:20:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 14 Nov 2026 20:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1794705609; x=
 1794712809; bh=QIES4zNTDxRjCnYHiHcWq6p6uX7fK/EWYh7I/zXroHQ=; b=p
 juVmr/LC7nCJ0SQ2rWUhRQGDMnlVGg/71zflyfizaeCefqOj8Wyp1bv5cUdTgRb8
 7XUxKSQFA4h5chwE1lADu0vrwg8OhHP6GoQHRhO7+gqlPzaI30gfxszAJ8iBZnAq
 w6LhtavpJKSJHCgIMJ9jaiAQhtgloSfAXiebl32YH12R4n49k4Dhf+Y8W3pLV4v+
 Lk6DFTk8SpQ9jSXzpScexBSvyhdEJDbrQwMC0927YExgznJjfLZe0flh8fHQL7IO
 vj78LH6slSiU2T+/dLzxP/iDcsVNxx1fb6S0NI/BKneEKfRIjGfp58LmRDVhLSom
 qjpjx4Q11TfgHJQJAHUUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794705609; x=1794712809; bh=QIES4zNTDxRjCnYHiHcWq6p6uX7fK/EWYh7
 I/zXroHQ=; b=syy3aDEccFqwMWi7OqQgN+5WtM3ZAfMLRFvK6Ty6zA65HPirgvN
 ilcYb0Q1wBWUsxvkCfegkY1pzVtpHUOC6WAP6pTtbZPWcSU2JRmZq5bj3XtaI5mJ
 5KZK4MCZjfikGyCw8udPD79DzKX657SNeo8VKm+NBs1zDN72HR3ZemlLBm38jus1
 WDdVI20E7k3nTziG5v/jPkof/xTKUHTBh7LLvCto0jlE2c4pmQs/fxRRAq0SyBeZ
 lruY2Ddh8f3CbRk7/EsENeVrGkeN2qYTfTHHssLqQwRRARUN/edAoqWV9ygwuEYm
 jIS3U35+DcIoM5H/MAq31DLvDAGEUQlNvVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=sakamocchi.jp a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794705609; d=sakamocchi.jp;
 mf=PG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPg==;
 rt=PGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Pg==;
 s=fm3:rsa-sha256:MMXL7gIROLJ2rfVHWnz+remrPmZo+fMplqSOXdDqLJnC3xA
 YD4sK3Z6w2DZlqL1uokHi8m/Ej3lbj1jckN0Aw7uyFzXnOiAjM0vLIfpK4QbGpS3
 hqz4hFYkHy8O8kUPgIOrmmQrwJGD3HWRKVnzm+eq05CXYlr786HJtiyU2PFKDOXW
 KcrRuKAVC5qVLnhpK1tE9ofbf70hTpCSROzNXi9r1HxAWR4U6g7bJv80Av6tRa4a
 niV5bBGmW4Y3p8ZA9/339HZcVYlGCOAHDcXU4xbpaXhhm/XLi8mkW9bgKMr163kz
 o/WJiTGRhxcOBO2jngfWZ9oKUuB7mJc28kEEDrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,mail-followup-to,message-id,mime-version,references,
 subject,to;
Message-Instance: m=1;
 h=sha256:ntV32t7KOIfGMot6swX3CNi9IkfeqivW9U6qBDwCqc8=:4RP5xhIBVdE4nHZvdVXdOxDGDwEwdGMsIHWUj8/gqfI=;
X-ME-Sender: <xms:xQj5aiop4gg9dsJ6_Vn6u45zXMYueatHm6sTqNkrPjF6p_uliIn0fA>
 <xme:xQj5ao-c0CruU-TGxTE7NFYZSaEuQncLSSmM997vVUnXnDFfvxt3Mt5vMRNmSfmhf
 34fKN--fbmH87piFvayMBFAxnjq6WHAkHe46t3SFxeylFtFg6aPnx9A>
X-ME-Received: <xmr:xQj5atXGMWjP8faJlCtXj9RrVZeBW-gqDucCpC0ZXa191cT5jnWReGYw_Z8rYiOMsAtlcaNqIM8bDcRsKH9aHiPzWCfQ_w>
X-ME-Proxy-Cause: dmFkZTGQstm6GOmXFdPQXDqZqAYG7aQouPeZUHJ4IBXrRYWFH6lFNnMWIuGsSOCFSsBuXW
 LbDJxfVrfV3cl+wc1JM2qA4EvGILGxXqZILW7GfZPYDe6vWDeehuWas6PsFLq2rp3ZCMLK
 vb2ZkQs61G65smsTsr3W8fx/U8N5II0Wva1plTCgHg5UpMnhi5PWu1EQKVr47yDlfh1UvS
 LYKjU/U9x7MTbsMHbdhB5rWUTX8pbvj9eAIRg5DGXYvFzZokg4/nvH5yq0IUoDc8xEYNrb
 hSXdXqov4GW1obuCd3P9CA8Y5vszeSouSKwogVvelkFQGttmZKq/NF5ipA4vDPXyrU1Xrm
 Zrz3WElYlhVCDcPNRnAGrD/gNAj1b7M9bHXUiJrCqgmTebsAx0cfPWnZGZ3/j9Ea2UWcPj
 qqJZ67js4v5NriJFPwSb5fBisbBQrZL2hM4YjWQCJ9uoloExIgLFI0L7sZA853RBWP4ncp
 DBuj0o8Fkgdi7cJEPrTBBMdPRnMErqVngCb+aWeUA0zKt+uaR6UB1bg9ZicNV0ayYa37yt
 I8T18lqRGBzHHbPK9Mrtu/1JSrYmpYKqgKJaY1owBZ4nprZ++3QPl5fwcLNIPsiGvSmzop
 Zbr1xrRPLyP5mMh+v5LgBzIwywaOGj2L4LIDZM+0lWqxfhjtWj2WgxvXglrg
X-ME-Proxy: <xmx:xQj5avAwgflb4ksIG5XRwHT6xxt96MMxRO3omUvuEt-3k_ppqJzgYw>
 <xmx:xQj5aka9rFrx7_oeihBM0qdilVdSsLFNvKaV60FpVwOaq7EoVM3bNQ>
 <xmx:xQj5ak3AzNFqwOx2mTfPhYibu1bQ_UDkW9NgFtUhfBWBcyXvs0uL4A>
 <xmx:xQj5aoGo_8KYcqvEjpNAxM_sotiXZsyQPcuJ_BoRuwGjdfls4pLNfg>
 <xmx:yQj5amBDENmX5NhRabHbZy5mqP0Iv6_jzPBpOZyadDNP-V1uD_qCKZw->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 20:19:47 -0500 (EST)
Date: Sun, 15 Nov 2026 10:19:45 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20261115011945.GA238787@sakamocchi.jp>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, David Heidelberg <david@ixit.cz>,
 oe-linux-nfc@lists.linux.dev, Chas Williams <3chas3@gmail.com>,
 linux-atm-general@lists.sourceforge.net,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 MPT-FusionLinux.pdl@broadcom.com,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 linux-mtd@lists.infradead.org, Neill Kapron <nkapron@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Hans de Goede <hansg@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
 devel@lists.orangefs.org, Paulo Alcantara <pc@manguebit.org>,
 Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Benson Leung <bleung@chromium.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-3-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261114202653.3113381-3-rdunlap@infradead.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSOul-000000001XI-2t8c
Subject: Re: [f2fs-dev] [PATCH 02/12] docs: ioctl-number: update sound
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
 linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
 David Airlie <airlied@gmail.com>, linux-scsi@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, intel-gfx@lists.freedesktop.org,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 virtualization@lists.linux.dev, linux-block@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@kernel.org>, intel-xe@lists.freedesktop.org,
 Juergen Gross <jgross@suse.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-bluetooth@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sat, Nov 14, 2026 at 12:26:40PM -0800, Randy Dunlap wrote:
> Update the list of files where sound ioctls are defined and update
> the ranges of function numbers that are used.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: linux-sound@vger.kernel.org
> 
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   12 +++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> --- linux-next-20261111.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ linux-next-20261111/Documentation/userspace-api/ioctl/ioctl-number.rst
> ...(snip)...
> @@ -168,7 +174,7 @@ Code  Seq#    Include File
>  'H'   C0-DF  net/bluetooth/cmtp/cmtp.h                                 conflict!
>  'H'   C0-DF  net/bluetooth/bnep/bnep.h                                 conflict!
>  'H'   F1     linux/hid-roccat.h                                        <mailto:erazor_de@users.sourceforge.net>
> -'H'   F8-FA  sound/firewire.h
> +'H'   F8-FE  sound/firewire.h                                          conflict!
> ...(snip)...

I overlooked this entry when inserting the additional ioctl commands in
the following commits:

* 90e8ac5c9d446 ("ALSA: firewire-tascam: add new hwdep ioctl command to get state image")
* 58b62ab702591 ("ALSA: firewire-motu: add ioctl command to read cached hardware meter")
* ca15a09ccc5bd ("ALSA: firewire-motu: add ioctl command to read cached parameters in register DSP model")

Thank you for catching and correcting this.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
