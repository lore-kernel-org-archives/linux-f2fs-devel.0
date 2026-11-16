Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D4606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JpMmrWgR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CO8o0l47;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QYqdRHTc;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ov44YrtP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=kfXNXCv1riYi3RV+Gw1Nl5UTXK/0Y8FNBIyvtGYY/vs=; b=JpMmrWgRgSuveEiFQ6ZRkkBtcL
	7kZ8WWpRznqt5f4NHtY2O6iDOjuAfbGqdlVUf9FQN8kXrVAEiIzxjA+R8kOPXZ8CcbmjnFptF7BFl
	rgyAqTIm+PgMaBdpUn4x/kzdJQ8aH0qhJuWTXQ8WWzJDE3uxT8cO9NCHY3pCQklZ0/50=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSkqk-000000005EL-3NEo;
	Mon, 16 Nov 2026 00:45:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xSkqh-000000005E9-0EtF;
 Mon, 16 Nov 2026 00:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nEPXf1cG5J+Lghgn3UQeDfptX1Hk+zVJPSj0Zk2IzFQ=; b=CO8o0l47hT1/yPA4GtKp6ZB4GK
 D2TzLGUxHsl7FcWY23eqoJQrKZIwi5IAsVc80kz0dbLnfL/JLxhd8gpd3hG15ixlX2o1KD1M/MBi2
 El6R1j82udFAsqJmBW0ryno1zrohQ2L6jrqZOs6GNNEHo/Szdjqoax0PRaVfIrXb0Vy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nEPXf1cG5J+Lghgn3UQeDfptX1Hk+zVJPSj0Zk2IzFQ=; b=QYqdRHTc8HpOPDamM+MvQS8Q8m
 KmEBkay8jwTtpxp4XrqRkM41nosR8I6NqcmrZjBDc8sv/4ZclaBkGmpV5MlZePAGTaZt0u3O4nvSQ
 S7q4+8bTPFcEEVys9GG27GaWgUfgxFx6lJEVtF1gBb3Mu5gHhUbvkN/fHzrUEd6x0DkY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSkqf-000000004W2-2i9z; Mon, 16 Nov 2026 00:45:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=nEPXf1cG5J+Lghgn3UQeDfptX1Hk+zVJPSj0Zk2IzFQ=; b=Ov44YrtPxUC++hYRNDHSdmdpGW
 JaxLbFR1NnGayLi7FHLtyTi+He4ZYSfoC7yWmGobJ7E/AIaLAiwDiqmK+og7vdQvnP4EzvIpr462x
 EDmrhZM3u/N2SWbcqZV+o7jR7R+AN7ZLDYmWxP5FpNx3G+I1qCrQflyake80HiJ9rMKVM/x4eT782
 9JEn4jhTrQPKUH9n7ugwPApkYe7cQrElzRWPUKP8gRVT9cQSw9rpPJq9AX3iS6GqmzfQn0wqcsM7f
 leTLxbzdojuK+f/LSdN/KzQKSZ97Y6xYotP0eKRTTUizqT5t8J7W/n/cd6b1FIlVQIvCGZw4VHm9P
 KD0dlVWg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xSkqM-00000000pP7-2dPd; Mon, 16 Nov 2026 00:45:10 +0000
Message-ID: <bbdb3140-dc5f-4ae1-a5a9-c2e25387409a@infradead.org>
Date: Sun, 15 Nov 2026 16:45:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-2-rdunlap@infradead.org>
 <f37ccd71-8e1d-4dd4-b11a-e22b9e617dea@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f37ccd71-8e1d-4dd4-b11a-e22b9e617dea@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSkqf-000000004W2-2i9z
Subject: Re: [f2fs-dev] [PATCH 01/12] docs: ioctl-number: update MM entries
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
 linux-doc@vger.kernel.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 linux-atm-general@lists.sourceforge.net, amd-gfx@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
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
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-rpi-kernel@lists.infradead.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/15/26 8:58 AM, David Hildenbrand (Arm) wrote:
> On 11/14/26 21:26, Randy Dunlap wrote:
>> Add ioctl number entries for test_hmm_uapi and gup_test.
> 
> Just curious, why do we care about uapi for test interfaces that never see the
> light of day in production kernels and their sole purpose is to go a long a
> dedicated selftest?

a. We don't control who builds/runs these tests.
b. There might be some USB gadget or HID driver running at the same time
   as these tests.
c. It's preferable not to have conflicts, so any additions to this file
   should try to avoid these documented ioctls.

-- 
~Randy



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
