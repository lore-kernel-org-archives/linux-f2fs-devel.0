Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D5CC5AD49
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4NrFM5Xr5HXskNZkzoRnSddvvc67zm4uxeVMtLOUZas=; b=gXVmV7FRIxv8k2IJHEcvVawzzw
	QvJozCyNJMpZHz/Pymai9Tq9D9qjb/+69zt+z5SQX1uwEj4CXwfIEO72XKUUZSrBtngtcVuB/itsJ
	8Yt6zAYwilaphrZmq/JS5UsQwlDH34CKeqhOkZHCP6VeRnDPcZNVd7WyQvovIUo0Ba+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uMLBx-0007Pz-TN;
	Tue, 03 Jun 2025 06:32:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uMLBn-0007PH-J1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 06:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kFqc6VdNWkVtoq3D81aSMo5KvSBNodIl9fIQJIJNwUc=; b=K3e3oWDd4KKZOcELzrcYQzmBiI
 9h7ne8TJQmwkM34A/O3/CJDv8KaGqfxrqdIN5yYLAa7H6g6tAS6SXymgbaRMVHx1pHAZ/5+ilsCJC
 6MsMfl2pZxBRLGfMJ0KJ8NHW6sVnCPjKlxPWQ+WN++IAasFs3oiGnY+WN1t5OagG29Xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kFqc6VdNWkVtoq3D81aSMo5KvSBNodIl9fIQJIJNwUc=; b=D0bWEJImXCNyC+ZFn+0dT0B1Mb
 jvwMXYNpZz048rsL9LyriJ5D+t7Goc/9JlFXfukym82/cuvy9Mm8M7EmV2BJhiU6u8LG1xLZ9yUFs
 0Quq1fcgGzHgOMTvxKi/HiOOYIKk4SmfwNVFdrlDwuzLTN2vgFetuzkcOFzOCz61ui+A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uMLBm-0008Cj-VX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 06:31:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EA6F614AC;
 Tue,  3 Jun 2025 06:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85BFC4CEED;
 Tue,  3 Jun 2025 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748932307;
 bh=DTaWC0NkSXOoT7o1IbYuGBZMUzk4wAoEkhyQa0+uLr4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=j8VP4JxBboAEbKbTgrly8bM5XLAapF5NGGbtorH6HwgFbv5ysZHImbiTQ5jv5QbHT
 S9LB3Q+JMhUHxjaTRyMDz+v5+vHo/ZFTRPR9AQRtVxnBWAbU8EixDZCAeWL9ogoapr
 n366k8Y1R/cdOZFVKlJj6gkUY3n/N/8phzxRZfi3aIwbFterzLNSbDtFFIAvIRYQMk
 0GhB24xgrcDZuKZhFZiFRglOgiwIWz9juU2sRk5LaaDUIRG17Vin4YU2mG+VdXeH63
 VxKCYNq9R1HpwOtAIErJoa7a+adLAem5kZRTCkqWyyOtHBFegfcJrgctGTWpqa/boD
 iNSdFizGWibcQ==
Message-ID: <f520c234-7b02-4087-a98e-33a51d2feba8@kernel.org>
Date: Tue, 3 Jun 2025 14:31:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20250601002709.4094344-1-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20250601002709.4094344-1-willy@infradead.org>
X-Headers-End: 1uMLBm-0008Cj-VX
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix __write_node_folio() conversion
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@lst.de>,
 syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/6/1 8:26, Matthew Wilcox (Oracle) wrote:
> This conversion moved the folio_unlock() to inside __write_node_folio(),
> but missed one caller so we had a double-unlock on this path.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
> Fixes: 80f31d2a7e5f (f2fs: return bool from __write_node_folio)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
