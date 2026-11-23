Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3648606A335
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DWlhlljD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i7lXuA9Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XcrjjVXL;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5brb9u8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GUMN0I6y1LM+Co0TDkTxOROZMruBoHUBi622wM8ptYU=; b=DWlhlljDm4GtS8MFIJJksRnrml
	5n9FUt9AizHVLJ5bQzD4gdZ0AMwaprJSwsgB7BVRv9Of+1LFHigS28xDVhH4QwP0HJHL320nicW4b
	BjJlc+ATfmT66jD3KZBzWBu/Br+DGyjJduPWqdarRquOa7wYfqqluU/LPTk4Vzp6PcgM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVIdS-000000001LM-1ur4;
	Mon, 23 Nov 2026 01:14:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tzungbi@kernel.org>) id 1xVIdQ-000000001KI-2HIZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 01:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1nAFz1rE2Zgq0kT2UJ5pKEhQqcU8lxqQXw2MrFx+Nfc=; b=i7lXuA9Z8LS5/mSPOneSxZl6XE
 yH8a8TR11N96vRnOmrS17e8HQ9kVMxlhSN6Mb/8FW/6YCF7iwTt4hHtsaJtQ04awnda9sorwkbr+T
 4HeDjLCYQawlitB+ApOCyV+ib0tqYtZxcfRGDUL0uCuRwFfaoY3CmTmm04UPpSSSOKRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1nAFz1rE2Zgq0kT2UJ5pKEhQqcU8lxqQXw2MrFx+Nfc=; b=XcrjjVXLOv2VxOZO4vjYq6ld5J
 XHAlEFt5auU6n8JWD/4FxzmbRloPyAg1yxYweLcdSuw7gRvobX3y4O+g0Mner0NQpMSAVczXIsAor
 lIQbatTnUYzFxW/Az2KR5J/J0aBcE2dKGBXVKeTjcIwFNjihxoQg7MHHuTMzjUa1r66k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVIdP-000000003SB-0dRo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 01:14:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A90CD411F0;
 Mon, 23 Nov 2026 01:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C351F000C0;
 Mon, 23 Nov 2026 01:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795396453;
 bh=1nAFz1rE2Zgq0kT2UJ5pKEhQqcU8lxqQXw2MrFx+Nfc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m5brb9u8foWKbi7SrlcdW6nE2yWIS8IEGVU5QHSZYMih+9IEkmiqaNM0lLx2EYbPE
 Ene3Ka2hJ1BAvW2vOWqYEoxo49rMX/8KuHKgTHWJQeFE3NrlIrAf3xeYL6VLmMY+/l
 ekFXnTI29+zSfV1Cj1JiY8g0iM3LpoM2wMrgHM/4k71UbfvjD94MuJKD4cUZLqKZBp
 tapIlLzsw5cg25rKFRJ3Wy6OzHRx9WFNJ4Dy/E+S8IHUzJbf1ziPCMSD/LFgujVS+y
 I6gkNfNt8+7zFmlY0xlcmT0RV+dcWLazJhMGzWNLJfBLUPxJ9MdE0Cw4N9AumibzJ+
 +Zbi9zcgZuE0w==
Date: Mon, 23 Nov 2026 01:13:59 +0000
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <awOTV4kbshpi_cxp@google.com>
References: <20261119053514.255348-1-rdunlap@infradead.org>
 <20261119053514.255348-12-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261119053514.255348-12-rdunlap@infradead.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVIdP-000000003SB-0dRo
Subject: Re: [f2fs-dev] [PATCH v2 11/12] docs: ioctl-number: update platform
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
From: Tzung-Bi Shih via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
 "Michael S. Tsirkin" <mst@redhat.com>, amd-gfx@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, MPT-FusionLinux.pdl@broadcom.com,
 Namjae Jeon <linkinjeon@kernel.org>, devel@lists.orangefs.org,
 Neill Kapron <nkapron@google.com>, Juergen Gross <jgross@suse.com>,
 Chas Williams <3chas3@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Marcel Holtmann <marcel@holtmann.org>, Sean Christopherson <seanjc@google.com>,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org,
 Jason Wang <jasowangio@gmail.com>, linux-block@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, David Hildenbrand <david@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 "Martin K. Petersen" <mkp@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Matthew Brost <matthew.brost@intel.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, oe-linux-nfc@lists.linux.dev,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
 Takashi Iwai <tiwai@suse.com>, David Heidelberg <david@ixit.cz>,
 linux-f2fs-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 09:35:12PM -0800, Randy Dunlap wrote:
> Update the list of platform/ files where ioctls are defined and update
> the ranges of function numbers that are used.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: no change
> 
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org> # cros_ec


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
