Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C751606A334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GPZ5PNfk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YLKUxcsX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fKleY13I;
	dkim=neutral header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=gYew8w2z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=lC54sYni/yPjsXZ8fHQfrzzRijGl/xb6Ujzlz9JXZN0=; b=GPZ5PNfk4pm/n/5G3yErnjodkl
	ljiUHQHMslM4jGgP3y/lnKEycFU5/QR36XKSIXZG+IJ2RwOBXhvufa5MJ6bK0xQ6yTwl+VRBsSdau
	dl+/XhYcJIYDfnxZoCtDXtObc2AvRVyfKU1mUvJ/adjqqn/54EsV06h1cDvNHPjtCaUU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWG7s-000000003nd-40Hr;
	Wed, 25 Nov 2026 16:45:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <corbet@lwn.net>) id 1xWG7p-000000003nH-3dhy
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:45:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=11zt4OupvieQqDw22Q2ubqyLm0TwPHTf9uDp8UQ/aNg=; b=Y
 LKUxcsX30CBobNNFPX9vJSVRFZsWTw97seleEqTF00HCravqn4booszsd0ar4jKoAA8w5XBUXwJtq
 OrVp4uqHZ+zRqv6Nr4pPzRZAentjw2n9jNkTrnEM48TxKgwrbhzhqQUXn6jd6B7se4k6W3qunJco/
 4TKW0kns91d/NsxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=11zt4OupvieQqDw22Q2ubqyLm0TwPHTf9uDp8UQ/aNg=; b=fKleY13ICzOZE6wUQX68dxz/+O
 9+PGcmFgoZhv7X0/9YeloJg4gOyrmvdLVplWhZnNCidvGLVIElYWbzHJ43kKEUM66/Mt6QZfMCAfy
 aeVG1xqgQmxnf5y2J8MlSmtqemGFx+WOikojz4zBYpQP8ofLTvT+OLsu/yiDFiaUhIG8=;
Received: from ms.lwn.net ([45.79.88.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWG7p-000000007WV-0mpd
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:45:41 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 164CF410D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1795625135; bh=11zt4OupvieQqDw22Q2ubqyLm0TwPHTf9uDp8UQ/aNg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=gYew8w2zbH6+bi/mBbqli+h0aBDamw00BioPDCMMC4Es4g+qCaaIw8gBYOLhfGAsU
 9mfNHzR2Wjt3eb5ezNkPplfVvqDZB4yLXc7H/uIjYl6k/R0SNrt0O4pqewchTPc4H+
 DoPRzU4+fJgJOU7hPx03jLkV4HVaXJMTTjxyrWRVyiE+GFkUio915W5ZUB0L5VMnbm
 Z5AtjEERksNhEMgjG3ZSm0ynjzhzYrKmQP0JaqQq4T6DitPDhHE0cz5cUJ9ItE/n9j
 Ip9FDRPDTnpXpMfA3rcqvq+BtjVyvtC+AdbQzNra/9WErFSqw5foLA7PdpN6n18WG/
 9pepodyHhS3sA==
Received: from localhost (unknown [205.220.129.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 164CF410D0;
 Wed, 25 Nov 2026 16:45:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20261125061340.3402300-1-rdunlap@infradead.org>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
Date: Wed, 25 Nov 2026 09:45:27 -0700
Message-ID: <875wxkx3ko.fsf@trenco.lwn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWG7p-000000007WV-0mpd
Subject: Re: [f2fs-dev] [PATCH v3 00/12] docs: ioctl-number: update entries
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
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Benson Leung <bleung@chromium.org>, David Airlie <airlied@gmail.com>,
 Leon Romanovsky <leonro@nvidia.com>, Mike Marshall <hubcap@omnibond.com>,
 Simona Vetter <simona@ffwll.ch>, linux-cifs@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
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
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Randy Dunlap <rdunlap@infradead.org> writes:

> Update file names that define ioctls and update the range of
> ioctl function numbers that are used where they have changed.
>
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]
>
>  [PATCH 01/12 v2] docs: ioctl-number: update MM entries
>  [PATCH 02/12 v2] docs: ioctl-number: update sound entries
>  [PATCH 03/12 v2] docs: ioctl-number: update block entries
>  [PATCH 04/12 v2] docs: ioctl-number: update networking entries
>  [PATCH 05/12 v2] docs: ioctl-number: update video/fbdev entries
>  [PATCH 06/12 v2] docs: ioctl-number: update SCSI entries
>  [PATCH 07/12 v2] docs: ioctl-number: update MTD entries
>  [PATCH 08/12 v2] docs: ioctl-number: update USB entries
>  [PATCH 09/12 v2] docs: ioctl-number: update virtualization entries
>  [PATCH 10/12 v2] docs: ioctl-number: update FS entries
>  [PATCH 11/12 v2] docs: ioctl-number: update platform entries
>  [PATCH 12/12 v2] docs: ioctl-number: update DRM entries
>
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   91 ++++++++---
>  1 file changed, 72 insertions(+), 19 deletions(-)

I've applied the series, thanks.

jon


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
