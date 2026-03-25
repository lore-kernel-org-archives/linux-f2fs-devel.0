Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E63109C034
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TX0ck9143CzyfRHganzshn/bydcreG4tiGEY2knAvw=; b=PaUo8liNlhRs/Lky237FcbRjx9
	An7RB2tphiblSLKLYCnc88a/QEaM3aBmn3rCt97bsBQ7iYD8gUhsEdxVXHFevMncMUd/CXS/QkP7e
	DcM95D2g+9Hn3825eYJ6stb2Ws0dZoqMz1jbyGG/aItF5639H7QNM2Rfqq7gWFkYppDc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5QlY-0000n7-Pw;
	Wed, 25 Mar 2026 16:07:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1w5QlW-0000mz-Dc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 16:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RzT8Skk8c/ogUzzG7VszBOgV2NIsmZj/7VrDsGFaz3I=; b=fC7TFj4MX1+LQrfMyWvGYWumH1
 mRHtT+BmOAjToSpMGLTC5/2yigSBadFmX06thxBvPktVBfcFNPnVsqOUk4iHCv35jVzEqUVAyEkZx
 rO0hpOKivyevA8ySBQ+/dR5BTMstWkRLnKQAjGGN6FInMSFPWWchwI+AMr94wf3pEc7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RzT8Skk8c/ogUzzG7VszBOgV2NIsmZj/7VrDsGFaz3I=; b=SADOb4eckTeHql2AhsrPfeY/JA
 I496ytdxWebwjlEHjL78pbZVw2CZ25fEfyM4YAwrqJxNEpoHIgiqtUpd9zvdsvejYJuvbRvautsAK
 J77pzMzKwwVpW4jLS8lB9IeDYCrB1apFq2pX2gg9DBIQQyLfAWJ7bL1V3WcmiRj5gfDw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5QlV-0004Zv-M2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 16:07:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CDD5C60127;
 Wed, 25 Mar 2026 16:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C9C2BCB2;
 Wed, 25 Mar 2026 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774454843;
 bh=15WFwQraSsREHmH5UCN+BSez5z7m4WAaAN6c1R3i/6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IGVGIIPY5KeAwDwktN1B3h1FTo6Ifrj2LJwH0YKT2ruyQCJjVeln1tlq7NXRR7MOx
 u3v0Gf/rOmZOc3JV8v8kfyIYxl+G9XD8bZDt3AMkCaXxHxojyIdRzfw3xFi3F4UooT
 b5GhFFNj51kDjfwGGRGaMy5DF15Jp8NWmK+TE69PoYWuxkuXQKi1hvjjdlRh2W47Ue
 5K/FvwMlFBYntnlhQ2Gl0kcYnyncLPRierVSguNx7Cbi2CuW3lWXGzIsMTJOt5gkpt
 ZwyWyu+Whjcfzi0QNMzKuiN+KrD6wsWAJx3JJ+g3mZ0bT+KIVUp/gbKHan/BTjaO1s
 K64jfIPSLC+cA==
Date: Wed, 25 Mar 2026 09:07:23 -0700
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20260325160723.GU6223@frogsfrogsfrogs>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-4-aalbersh@kernel.org>
 <20260325075700.GC952@lst.de>
 <vatqzcvepp7z6iotzayuyh7fajwdqs76pn4o3sdn3f5thiwsjc@dt46ylrbjnkp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <vatqzcvepp7z6iotzayuyh7fajwdqs76pn4o3sdn3f5thiwsjc@dt46ylrbjnkp>
X-Headers-End: 1w5QlV-0004Zv-M2
Subject: Re: [f2fs-dev] [PATCH v5 03/25] fsverity: generate and store
 zero-block hash
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 25, 2026 at 01:03:40PM +0100, Andrey Albershteyn wrote:
> On 2026-03-25 08:57:00, Christoph Hellwig wrote:
> > Shouldn't we still try to get this out of the fsverity_info first?
> 
> I don't really understand why, this hash depends on salt (inode
> specific) and merkle tree block size (also inode specific).

Agreed, the merkle tree geometry and salt inputs are per-file.

I sorta wonder if the file ought to get an autogenerated salt if
userspace doesn't provide one, but not enough to go digging any deeper
into "does that make sense?"

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
