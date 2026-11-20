Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA70606A331
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bi+3vgQZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ki3nCS2o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hK7TssE4;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dq2Owl4T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:References:Message-ID:
	In-Reply-To:To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Vj1ZCGZXDjz5ttp4B/ZufqGN8+NVw2qriEy9HGc29JU=; b=Bi+3vgQZVv6WJQ
	VTk2R0LFSTTSMQnSvvxvKwR+5hpTSOmEg3Olrav/t3y1gwAQwtNDYeNgk9rDOhqO0BN8nwEdS3IVA
	U7LQ3tCoYE7fK7PrgzKRatsGkHc14eYLR0qD97Lb9gFnB9V3qNfe26sw7LZY4PtvnSa83VBKfDSow
	1xU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUET4-000000002Y8-1K3L;
	Fri, 20 Nov 2026 02:35:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <mkp@kernel.org>) id 1xUESc-000000002W0-0aZA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 02:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Date:References:
 Message-ID:In-Reply-To:From:Subject:Cc:To:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yLxaIFgMgiNdJ6EvHj90KmNsd7UyUa4rOHQt8MkQ4o8=; b=K
 i3nCS2ojvYQOquwDOfJsgXJZOJYGgcTlQNnHt8+Deeu1YZoMFLBmF+JtZDpueBR6Nq97aKdbqKqOK
 lJUIsRFZOBmAtxLDouEbF3WfxSi7/e6f4YlqCjmBsj4Swv+Zvk6rUJHL0mEeIsWWArcNvutXQVqIY
 A37hY+NoYP2sBE/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Date:References:Message-ID:In-Reply-To:From:
 Subject:Cc:To:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yLxaIFgMgiNdJ6EvHj90KmNsd7UyUa4rOHQt8MkQ4o8=; b=hK7TssE4fU8/JqED0ivlekK6QC
 0fGOIsylpcEbSM69BThnnTbBpryC/u3YTZJKq4iYyiCFMkHK1Ovk7zV5D9nnwJI4RX8N864WoCSXI
 SRc1fZdaWLFousqclgRTeTdQ8cz41Kpww8zoC3Ebfdm5ONyt36s4U3DuAaZ3HaPznXEA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUESb-000000001CJ-2lcr
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 02:34:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1BBF601C9;
 Fri, 20 Nov 2026 02:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6D31F000C6;
 Fri, 20 Nov 2026 02:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795142079;
 bh=yLxaIFgMgiNdJ6EvHj90KmNsd7UyUa4rOHQt8MkQ4o8=;
 h=To:Cc:Subject:From:In-Reply-To:References:Date;
 b=dq2Owl4TQH5i1O8lPJeqrs/bhVJe74UawaV8WZGOjcpXryG9VX5bBPEuofmjMl6C8
 KEMZUEWUmofCrIT9kL1mF9sqs29c0Cyil2oxP83BwPsBQxJM3XbOQHwaj2x7OkBm3R
 Ubt4udGPNHycSNftWKTVPyy9zKiSLnNOhFSlFIOPsiCL9/KFgmw/r+jfOmYYUs/VC/
 SAI+QguGa/5ffH3iaZeehgrULZs3TCS3y0wcIRBQ7+1cYjuY8NOZbiPkIC9OoceHPS
 +R5fZniZZazVx2uAAw4qgmr08ft+ySZxWB+NNVSP3BxvosYlgijyZSgy8PCf4WR5j7
 gqEvBh4+Qs7GQ==
To: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261119053514.255348-7-rdunlap@infradead.org>
Message-ID: <yq1eccgqlhr.fsf@mail.kernel.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
 <20261119053514.255348-7-rdunlap@infradead.org>
Date: Thu, 19 Nov 2026 21:34:38 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUESb-000000001CJ-2lcr
Subject: Re: [f2fs-dev] [PATCH v2 06/12] docs: ioctl-number: update SCSI
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
From: "Martin K. Petersen via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Martin K. Petersen" <mkp@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Vignesh Raghavendra <vigneshr@ti.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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
 Jaegeuk Kim <jaegeuk@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Martin
 K. Petersen" <mkp@kernel.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6?= =?utf-8?Q?m?=
 <thomas.hellstrom@linux.intel.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Matthew Brost <matthew.brost@intel.com>,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 oe-linux-nfc@lists.linux.dev, Florian Fainelli <florian.fainelli@broadcom.com>,
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


Randy,

> Update the list of files where SCSI ioctls are defined and update the
> ranges of function numbers that are used.

Reviewed-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

-- 
Martin K. Petersen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
