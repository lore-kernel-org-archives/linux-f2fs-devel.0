Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412EECA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLCDyJZg0nDu4WquTiYoalwn+R4GTHT+8NGSN/yelw0=; b=egsArYa+QeanQtCMw/L2thyK2a
	fCvRzUPY7s+YjPe9Dskd0QMCG2JOCeQp7Ou6YS+7/clPevMikyTyGsxhzFrL/Ud7YkKf6QO/d67aE
	y/ATwR23SikUy5KpLXWFUV1JfjcyxWqvsBAS73MUZhwOwKB2aVynwuomVC4V0y4AVHuM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDgpz-0007Mj-6g;
	Mon, 05 Oct 2026 11:26:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xDgpy-0007Md-0v
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 11:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m/RFPJLbxCCsKLCIEVyjoB1hnKSFrK8qIznZiVq7CJE=; b=C9MGYku5HkLhbBgGbixrmwNKoc
 /c8D5tWhPfb/2AoPRAVo+Mbl8jxGOG7dERuhYcXfHqI8JbpM7hWniltflB47aaEqttgKGpaIDz1Ur
 eSNeiYGqZKrBDfewkcHsyPSPxLGiaXgxz6oFDiqG74PTWKTsEsBT9mCP/i8Y+pLJ04pQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m/RFPJLbxCCsKLCIEVyjoB1hnKSFrK8qIznZiVq7CJE=; b=JBGS8WbOz5vfYWCpdq9d0InX1/
 Vg8SqlADzeKl7PTgGYhSixYydbSvNDQ8pcVAjGbrS4d1aNAGpBglu62J0Eg/by7AdW+rj/45nwKq6
 SztOE9+PW0WonlcgfMNLjQ8bWL3MtZXw/mXeJE+RNGZN3HB0lsAZO3/brShFWpQNP47I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDgpx-0005TC-CF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 11:26:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09BD2405AC;
 Mon,  5 Oct 2026 11:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215401F000FF;
 Mon,  5 Oct 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791199583;
 bh=m/RFPJLbxCCsKLCIEVyjoB1hnKSFrK8qIznZiVq7CJE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dnxfPnlE+42vQT4C95ek8OLdUjS7Wr+HWYBSC+aAPDlopzSF1LVHjdHGQG+pdYac3
 po8ww2oKHe78fL5qpW5UgPRkJjcCevWbsJyTl80sK/nzOMDpJJOcA+qzWRK19Uh8dc
 VGzIQY6FnyMegIqHrQDOthh2MkzdPhG6+aoyQn40ZPvbeivJyaVq/YtCcPqziPclrp
 qb8kUAMutvVmCzMUHS9/wPHMC/RgDuF9/HkMRX9jFbG9Jjcxusl3UHKwyumbzuEsPB
 SjLOML9rTeRWBawSXYy2FE0+7y/Gy6y9srnpvqZ4R1UUZeExPVrT+VfS+1vGmHH/dY
 gwYR82EHOcl6w==
Date: Mon, 5 Oct 2026 13:26:18 +0200
To: Carlos Maiolino <cem@kernel.org>
Message-ID: <asN8lCPmZpA0tp5S@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002232542.GA15366@quark>
 <asDvqctUgrxflcCa@nidhogg.toxiclabs.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <asDvqctUgrxflcCa@nidhogg.toxiclabs.cc>
X-Headers-End: 1xDgpx-0005TC-CF
Subject: Re: [f2fs-dev] [PATCH v17 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, djwong@kernel.org,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-10-03 14:07:23, Carlos Maiolino wrote:
> On Fri, Oct 02, 2026 at 04:25:42PM -0700, Eric Biggers wrote:
> > On Sat, Oct 03, 2026 at 12:36:41AM +0200, Andrey Albershteyn wrote:
> > > Andrey Albershteyn (19):
> > >   fsverity: report validation errors through fserror to fsnotify
> > >   fsverity: expose ensure_fsverity_info()
> > >   fsverity: pass digest size and hash of the all-zeroes block to ->write
> > >   fsverity: hoist pagecache_read from f2fs/ext4 to fsverity
> > >   fsverity: don't allow setting DAX file attribute on fsverity files
> > >   fsverity: hoist statx reporting of fs-verity flag
> > 
> > Would it be helpful if I applied these six patches to fsverity/for-next
> > for 7.4, or do you want to wait for the full series to go in at once
> > (presumably through the XFS tree)?
> > 
> > - Eric
> > 
> 
> It's your call, I *think*, this is too late for xfs 7.4, so I want to
> queue it as soon as possible for 7.5.
> 
> If you want to take the fsverity patches into 7.4, go for it, then the
> xfs ones I'll pull in once yours are merged.
> 
> Sounds reasonable?
> 
> Carlos
> 

Fine with me too

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
