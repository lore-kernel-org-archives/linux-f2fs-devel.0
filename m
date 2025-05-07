Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540F5C369DC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 May 2025 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSjOij5dFWHM8kDLpfRpuao2wITo0SdyTeJiWsAF5wE=; b=e9IlaVbwuY3QU20U5WSLcMJERr
	G9bbhmahNzWgE9NBVc3AbrqfaIYXPzo+uxt+YO9PFn3nt+AXpO+eIxnjNTLX9UKbaarutQPUZtWdX
	UFotBn442SrexC/t0+2DYwQ//1lrKOxjbLiAFBD+Y3Dx95+zGaYs2SvkAGHHiksTiVEk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCYBE-0003jq-At;
	Wed, 07 May 2025 06:22:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCYBD-0003jd-3K
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 06:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MVIhB1BEWn6S47MzkpVUgaUnH6Pv++0Z+j0fyilfYzk=; b=OhkB/OoReocsm/ltY+9WY/Phtm
 N+ATgTxingnkPdhJUgyi0kr4F2i7YJ4895pUGcdT7FDqiCJfQWhszztJ2Jk8Yl0EBPlE7FWnxnfZ+
 oHCiE3Wa76MTUIUhUZP+pbWVcTWwkRl9T/PcOWIqWMqSkr+UqlZN17oSX83rQsoPbYnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MVIhB1BEWn6S47MzkpVUgaUnH6Pv++0Z+j0fyilfYzk=; b=dCZ1YDT3ubyW9losc0LzTyFWZ2
 leDrfi3ixFpYs7D123jLCvcltrx6KOtxXz1wjyvmpvYMCwGqArSErDzwpqhvEXQMGMa9xPzKWWhCf
 Xg8InDrfbQnJ+c4nL2LKpYLJR7oIaicQngxs5MTQxkU5DhPfJ+PrvmP37ObGCbqVAX+0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCYAx-0007Zi-JJ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 06:22:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B221629E3;
 Wed,  7 May 2025 06:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ABDC4CEE7;
 Wed,  7 May 2025 06:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746598948;
 bh=gFMTXhDvLooSbTLuEX6lJslPVQFV4FZCukV7MEm0y1Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=cgiLWmhSvVCKyHyPL6Tu7wtwTUysBwzQUcKAMhTCXOoz88Om/GykSE54z01NVlJs+
 JVAnzby969+IpXCnjGHdv/vJRst4VSEQ5WOA0TiTeWCupdAivwuyaouk+BpxZM3IO2
 TMKSjbreTizZ47B1BzmAViZ0+Hv8jhgrya9xYD5SUYQfRbgHzkYW5/JKfihTtQtLe+
 fMuhBHGS8uEzHoJCwoP/aAtOrgPJFlLezEGyLm13HtvijghOshOP0XJe+sNx9w3sfc
 0F8YTHwiqB3CFMxicPRTi9YXj2rNHxlMZoSlHKHO9ThwAhM8GvOyPkxjoYqMRXI6oU
 +03w/6Uv6G/AQ==
Message-ID: <d8467687-7331-43e3-8a9c-8a26974d229d@kernel.org>
Date: Wed, 7 May 2025 14:22:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250505092613.3451524-1-hch@lst.de>
 <20250505092613.3451524-2-hch@lst.de>
Content-Language: en-US
In-Reply-To: <20250505092613.3451524-2-hch@lst.de>
X-Headers-End: 1uCYAx-0007Zi-JJ
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: return bool from
 __f2fs_write_meta_folio
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/5/25 17:25, Christoph Hellwig wrote:
> __f2fs_write_meta_folio can only return 0 or AOP_WRITEPAGE_ACTIVATE.
> As part of phasing out AOP_WRITEPAGE_ACTIVATE, switch to a bool return
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
