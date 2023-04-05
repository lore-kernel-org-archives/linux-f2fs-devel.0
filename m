Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA20C7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 11:08:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk0zx-0000if-37;
	Wed, 05 Apr 2023 11:08:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1pk0zq-0000iU-Ok
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 11:08:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LzJaUmfW7LSdhmFGvI4GPq0lFJqiEtn70THgtiWFu7E=; b=RdgErkTWmcEUZEyccyDvuzN+Wj
 8MgU6WGAE+nVgcJCpmcEMZSk5FpUMI1dnZvfIjSbe29hHvim6DihBCRK0alNJs34OUrxt8T5fsW/H
 4xwSDxy7syE1UHsw4boLgFK7zmFX6ZFpDtNudjA3q1LOTXGgOXpPgTu5UAS7hyuJu7hQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LzJaUmfW7LSdhmFGvI4GPq0lFJqiEtn70THgtiWFu7E=; b=GncCnwL7irnLPHtdNzrOOgRHot
 oISqwGFAwKK+SNEuXOG/PtwnliIgGqSvPUptIJQbk6aqre12dC2GBfmx3cMUx2+3EncOBMEV/eBHz
 uUPV8tLFYYNboyM2lvY/Pbe7GcltBYkrw0oLODBFyqfLrklTUygQVmMPSb7idJO1Kl1s=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk0zn-00FwKV-09 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 11:08:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680692879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LzJaUmfW7LSdhmFGvI4GPq0lFJqiEtn70THgtiWFu7E=;
 b=RPfQ1HaKn4lVvr9dRPj/oGHc13B47VdQ30AiipV9qDPYZTRtpQokIo/cTxXaxHbgD/H9v2
 H+3ihRPeowyh4EdwQ0sMxKjhkRylTPkUMSImqkZJXHdM4p0cW62S8WoVZ4gbzWsL01v/xH
 IDVPe8Cs8Ib8yDJDT+wG/oeFcJavqtA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-ihtwr5iaMVC83taws3AS_w-1; Wed, 05 Apr 2023 07:07:58 -0400
X-MC-Unique: ihtwr5iaMVC83taws3AS_w-1
Received: by mail-qv1-f72.google.com with SMTP id
 r4-20020ad44044000000b005ad0ce58902so15952873qvp.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Apr 2023 04:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680692877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzJaUmfW7LSdhmFGvI4GPq0lFJqiEtn70THgtiWFu7E=;
 b=GVKLg3KTJpRMWLbNxQcqdSTAwJV6Th+1TRSbyXiKUEc0tJLzw4KTQ/686w6Hla2KlG
 zC78uFVWJIPRJRaswb7xdCm1jh/osZvPvNIDDqj4RZKmkUb8g/Wyf3bfCWoedwXHwiN8
 OzX2TRVFH3IgpsS7a1iZcAjoCmvyZ+XnKe6luyWGwsApN7/4mkjZ44FLTSVVdqvWo6wF
 YLQeGqbO7lcKGEz74gr5O9ZshbvUaY+BgAQW6/eCRRXxeN122ltd8xeqd7yw6BzccUG0
 BOqauFnnMULv3ox/c62EgedwrLFv50aGhY5VoTtCHlp22xMQM2TPkrNCTD+KOelrLFLs
 +b6Q==
X-Gm-Message-State: AAQBX9dpyeKLW8pPPjfSnRQtukoMDMOUleoJZGTjtH56vG0SLLa/v83u
 T4xHz6wkUBzR8+o/Z5krJn+cQK9Fzx84POXoRROuPXr+UbmJJOvJ6OXO2adsubLg7oSEfaZkh+I
 JJHuparaoRvCpOetqhVHx4OVChkXJpbpFmfYY
X-Received: by 2002:a05:622a:1a9a:b0:3d2:a927:21b8 with SMTP id
 s26-20020a05622a1a9a00b003d2a92721b8mr4385120qtc.11.1680692877532; 
 Wed, 05 Apr 2023 04:07:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeP9y1P8OSuMOyueFPI4oWaLkw1tcoh1zocY7G03xptTKH+In+mgb9Q5Zm39xqD2zbBaEQ0g==
X-Received: by 2002:a05:622a:1a9a:b0:3d2:a927:21b8 with SMTP id
 s26-20020a05622a1a9a00b003d2a92721b8mr4385083qtc.11.1680692877295; 
 Wed, 05 Apr 2023 04:07:57 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
 by smtp.gmail.com with ESMTPSA id
 k19-20020ac84753000000b003dffd3d3df5sm3934121qtp.2.2023.04.05.04.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Apr 2023 04:07:57 -0700 (PDT)
Date: Wed, 5 Apr 2023 13:07:52 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Dave Chinner <david@fromorbit.com>, ebiggers@kernel.org
Message-ID: <20230405110752.ih5qvu2cr6folkds@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-17-aalbersh@redhat.com>
 <20230404224123.GD1893@sol.localdomain>
 <20230404235633.GN3223426@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20230404235633.GN3223426@dread.disaster.area>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1pk0zn-00FwKV-09
Subject: Re: [f2fs-dev] [PATCH v2 16/23] xfs: add inode on-disk VERITY flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org,
 djwong@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Eric and Dave,

On Wed, Apr 05, 2023 at 09:56:33AM +1000, Dave Chinner wrote:
> On Tue, Apr 04, 2023 at 03:41:23PM -0700, Eric Biggers wrote:
> > Hi Andrey,
> > 
> > On Tue, Apr 04, 2023 at 04:53:12PM +0200, Andrey Albershteyn wrote:
> > > Add flag to mark inodes which have fs-verity enabled on them (i.e.
> > > descriptor exist and tree is built).
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  fs/ioctl.c                 | 4 ++++
> > >  fs/xfs/libxfs/xfs_format.h | 4 +++-
> > >  fs/xfs/xfs_inode.c         | 2 ++
> > >  fs/xfs/xfs_iops.c          | 2 ++
> > >  include/uapi/linux/fs.h    | 1 +
> > >  5 files changed, 12 insertions(+), 1 deletion(-)
> > [...]
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index b7b56871029c..5172a2eb902c 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -140,6 +140,7 @@ struct fsxattr {
> > >  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
> > >  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
> > >  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> > > +#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
> > >  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
> > >  
> > 
> > I don't think "xfs: add inode on-disk VERITY flag" is an accurate description of
> > a patch that involves adding something to the UAPI.
> 
> Well it does that, but it also adds the UAPI for querying the
> on-disk flag via the FS_IOC_FSGETXATTR interface as well.  It
> probably should be split up into two patches.

Sure.

> 
> > Should the other filesystems support this new flag too?
> 
> I think they should get it automatically now that it has been
> defined for FS_IOC_FSGETXATTR and added to the generic fileattr flag
> fill functions in fs/ioctl.c.
> 
> > I'd also like all ways of getting the verity flag to continue to be mentioned in
> > Documentation/filesystems/fsverity.rst.  The existing methods (FS_IOC_GETFLAGS
> > and statx) are already mentioned there.
> 
> *nod*
> 

Ok, sure, missed that. Will split this patch and add description.

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
