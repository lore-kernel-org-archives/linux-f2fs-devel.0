Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBB606A33B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VQsMC+NF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QN77a+Hw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c2V+Q2jV;
	dkim=neutral header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=Au1x/Qfi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:References:In-Reply-To:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2CxgzTEhG1hbdf8BNgjHfjDrlMVWdbGtvTCqLRoUhRc=; b=VQsMC+NFAXGHPj
	5b2DHWs3rulAaXyLauGrIxIShvMsTGBXfFY2f6fND4GFnl4OWfoCEy6OIL48ckHh/5mjImjPwqntF
	3IMvrfRVmzp3feJuMxxuXDh1JKDwNKo2FfT5Z9K2YUNilwptMPhlTe6T2CTRPf5/nIE2c9Hj9ihFO
	YfE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWG1G-000000007o2-3BIa;
	Wed, 25 Nov 2026 16:38:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <pc@manguebit.org>) id 1xWG1F-000000007nw-0fnF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Date:References:
 In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MFjp1Epxvbzt1A9g4t7Y/jDE3CxQAavGU4RMdlNgNPA=; b=Q
 N77a+HwTRb5FtjKi5I0pw0LBa1M5H+uy7Msbbth8eGF7uk/Utwl5XGvxfeJunJ/956I41awZarxZ8
 Y5WmVNgqX3ihZrRVwuI7sDbc6UqTd3u0OKbcwch4cbSR7Qj5o2LrOW7YlOq4lEzpU85B2/hU8Xqjw
 Gstjm7UPeS8Rvjdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Date:References:In-Reply-To:Subject:Cc:To:From:
 Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MFjp1Epxvbzt1A9g4t7Y/jDE3CxQAavGU4RMdlNgNPA=; b=c2V+Q2jVD3PsFJoBi+SIY1m+q5
 MeBzhmpjGqKHeWWHxTvYvef97EaNBEUcVa3UoH7QiGLdfQyIPMA84jA1Bk4MnTsGnGV6p9LVBu/Gr
 Seznvg5jnZcqYA54vw9EVw6b2kMTdwFdJKhZ8xbjsZ7brmkXx+zjqaYRb+b14+vVvb54=;
Received: from mx1.manguebit.org ([143.255.12.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWG1C-000000007Hb-1k4S
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
 In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MFjp1Epxvbzt1A9g4t7Y/jDE3CxQAavGU4RMdlNgNPA=; b=Au1x/Qfixdt8Oeg5ELWQmTzZ7d
 wr1MiZso849kQQI90RjKYgtWlHvOsL4sUODQa+yJU/QJtei3+nwrCl8XPzyxSYVWxD0jEkv9ZHfHG
 OmNUZEcDaNBk4Nn1E9cP7BuRGcZNEM6J6xtS4Ket7/m79g97o7hU8kn2wKyFBLeu8gwPpXcQdviQ+
 Hln2JCas14QUSmhfJsWIjqhstDco/PUWJlhmY/+248fQXkeCIGO5O9nEwcb7Q1W2v+0HrcyzdyrIT
 XwITUgiGSX5J7ehQY0B1lclNs46kSXv1DsiPlzDA2AP0RSCXykcJrKqmOyVKoOLO8j21CyIPiZYaT
 T4+/q8fw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.100.1)
 id 1xWFjN-00000000vNZ-3XTu; Wed, 25 Nov 2026 13:20:25 -0300
Message-ID: <9afd33b0951849b9a48c5a0783d76fde@manguebit.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20261119053514.255348-11-rdunlap@infradead.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
 <20261119053514.255348-11-rdunlap@infradead.org>
Date: Wed, 25 Nov 2026 13:20:25 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWG1C-000000007Hb-1k4S
Subject: Re: [f2fs-dev] [PATCH v2 10/12] docs: ioctl-number: update FS
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
From: Paulo Alcantara via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Paulo Alcantara <pc@manguebit.org>
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
 linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, amd-gfx@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@ursulin.net>,
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
 Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.com>,
 David Heidelberg <david@ixit.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-bluetooth@vger.kernel.org,
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Update the list of files where filesystem ioctls are defined and update
> the ranges of function numbers that are used.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: address sashiko review comment (ext4 00-2F range referred to
>     the wrong file name)

Reviewed-by: Paulo Alcantara <pc@manguebit.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
