Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922CEC77B6C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 22:27:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkBb2-0000z3-20;
	Wed, 05 Apr 2023 22:27:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <david@fromorbit.com>) id 1pkBb0-0000yw-Cp
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 22:27:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XK91TzLV+BuNFfVuafZ92bpnVCXIC7GzKLzoDgloMhQ=; b=f451aAwiCVx4Ke4qwl1/NczpdM
 Eru2refP4iSCyYWyr2I/+Rcs65CX+GoWSk84oK1xG/eMrudHaFCbb5CAGB03Yk8ljBGi6i4PqzXvf
 6GPTFjqav69rn2tjLFtSrLTenFMLo2E17k3Yk8+qk8hMY4Bmp0mcJMjJ7GoG1hpFzXHc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XK91TzLV+BuNFfVuafZ92bpnVCXIC7GzKLzoDgloMhQ=; b=G3YXuygwWuH8nYZY338whHt9vO
 ytotPYy7G27rqm9T0Hvlx87zR2TI4yM/n441lvISBMv5PcAaiHaOUMtseRQh4MM4awb0/3t5EMyZb
 +WWPxtzxA7NCjo6L0zfUGsV2pFaylX1tMbsbV7sWAudSZJd6RrucbAN2KAoVqL19xdWM=;
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pkBak-0004Ny-9Y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 22:27:11 +0000
Received: by mail-pf1-f179.google.com with SMTP id q20so13513272pfs.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Apr 2023 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680733610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XK91TzLV+BuNFfVuafZ92bpnVCXIC7GzKLzoDgloMhQ=;
 b=phPcb/SN25q2kw/FZ/aTqEL2YPFWV1/ZElIAli3MXwfTv+tjVLKBBur9WuCBaHCACZ
 D0ju4+GcM15ciS601Xut6OQO62IcxpBJTZB44/j8jsTfzgxzPHi6TdM4MY4h6EyEny7j
 BbdxTD7Y3B8eY3yR5kJLlHPTG42T+G04/g6dTuxR8Njnk2FYDl45LZH1iZ4SC7iVdwTL
 tTVNywDojFuzLzWPQMIgKhwVwu6aApOhjuoSmwEpixB3aP31p9E2vZt7xOTDI/JRk5fv
 sCNqzrkqiBz4QGhA8yapRr2so2J+w7D3gNKPhFHxFD9sZSe0S5qmiAchEhtJIawjKa7P
 E+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680733610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XK91TzLV+BuNFfVuafZ92bpnVCXIC7GzKLzoDgloMhQ=;
 b=SUMjbWeXYYFnno0kxb1ecPGsMGNGNAlL9KHh74p+MKo5Z/Urm8Ff4dN8afeauhXoGS
 oG2dIQSKySD3zEiEF8CWHqfCKlVCCRo+gyEhDj+CLOr2jlx3x62LP56SoSTPt9QpxClZ
 xrMB6dMOFHiUhuMHM2IwxHgt40Uc8JUp4OOFsrKUN/pmJCRyhRXWN//6Dr4aOsgx7bTC
 oZgF7X0wZWi8JOXin5/Mx6DEY4QRllP+l6Ujnj4LgUkvrNjgxGLhdw7mL2vV3J/HRwRN
 ze7M6FWXH7okVNZeAhcUXZXbm+RQj/Penk9QT4wSwb8TbW+qQBTDMFpDjSe6U1G0ex5w
 VLuw==
X-Gm-Message-State: AAQBX9c0sM6FOMFbAQKGV1m91WwpomdlVF5xYHEgMSTTi6wtT6p33IEa
 ISOm6IdsJ1h0B6ofACazuk8/SQ==
X-Google-Smtp-Source: AKy350ZizTU3q/Uc2TiZy7crqeJ4jvK0CtSZoX/AzNtdP+Y2QHldAbm030UMhCShfo2v0Sb07Y+LGg==
X-Received: by 2002:a62:1d8f:0:b0:627:e577:4326 with SMTP id
 d137-20020a621d8f000000b00627e5774326mr6595721pfd.17.1680733610237; 
 Wed, 05 Apr 2023 15:26:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au.
 [49.181.91.157]) by smtp.gmail.com with ESMTPSA id
 2-20020aa79142000000b0062c0cfbb264sm11493110pfi.93.2023.04.05.15.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Apr 2023 15:26:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1pkBaY-00HUjN-NL; Thu, 06 Apr 2023 08:26:46 +1000
Date: Thu, 6 Apr 2023 08:26:46 +1000
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20230405222646.GR3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZC264FSkDQidOQ4N@gmail.com>
X-Headers-End: 1pkBak-0004Ny-9Y
Subject: Re: [f2fs-dev] [PATCH v2 21/23] xfs: handle merkle tree block size
 != fs blocksize != PAGE_SIZE
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
From: Dave Chinner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, agruenba@redhat.com,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org,
 damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 05, 2023 at 06:16:00PM +0000, Eric Biggers wrote:
> On Wed, Apr 05, 2023 at 09:38:47AM -0700, Darrick J. Wong wrote:
> > > The merkle tree pages are dropped after verification. When page is
> > > dropped xfs_buf is marked as verified. If fs-verity wants to
> > > verify again it will get the same verified buffer. If buffer is
> > > evicted it won't have verified state.
> > > 
> > > So, with enough memory pressure buffers will be dropped and need to
> > > be reverified.
> > 
> > Please excuse me if this was discussed and rejected long ago, but
> > perhaps fsverity should try to hang on to the merkle tree pages that
> > this function returns for as long as possible until reclaim comes for
> > them?
> > 
> > With the merkle tree page lifetimes extended, you then don't need to
> > attach the xfs_buf to page->private, nor does xfs have to extend the
> > buffer cache to stash XBF_VERITY_CHECKED.
> 
> Well, all the other filesystems that support fsverity (ext4, f2fs, and btrfs)
> just cache the Merkle tree pages in the inode's page cache.  It's an approach
> that I know some people aren't a fan of, but it's efficient and it works.

Which puts pages beyond EOF in the page cache. Given that XFS also
allows persistent block allocation beyond EOF, having both data in the page
cache and blocks beyond EOF that contain unrelated information is a
Real Bad Idea.

Just because putting metadata in the file data address space works
for one filesystem, it doesn't me it's a good idea or that it works
for every filesystem.

> We could certainly think about moving to a design where fs/verity/ asks the
> filesystem to just *read* a Merkle tree block, without adding it to a cache, and
> then fs/verity/ implements the caching itself.  That would require some large
> changes to each filesystem, though, unless we were to double-cache the Merkle
> tree blocks which would be inefficient.

No, that's unnecessary.

All we need if for fsverity to require filesystems to pass it byte
addressable data buffers that are externally reference counted. The
filesystem can take a page reference before mapping the page and
passing the kaddr to fsverity, then unmap and drop the reference
when the merkle tree walk is done as per Andrey's new drop callout.

fsverity doesn't need to care what the buffer is made from, how it
is cached, what it's life cycle is, etc. The caching mechanism and
reference counting is entirely controlled by the filesystem callout
implementations, and fsverity only needs to deal with memory buffers
that are guaranteed to live for the entire walk of the merkle
tree....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
