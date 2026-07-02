Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C557C43327
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8XsfXCcsjqxZ0aM5R7DwWQxAMjgriiXTJCxrfO3b/g=; b=C23r/Lz5d0Oxfw3FVht42Av9E/
	loosW+WsFk3Rzvow+o38K9Xawhk3ufdGV5NZbTV33PhmYK2hDM3cCplxW4PTSwnMJtsYtyCLuawWY
	H6nRtDV6dOzri//98Rzybej9+xvweUuo4GAoUzNSZfnRajZOZj6E3hFyB5X9Vsz5QGCU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfBtL-0004He-FT;
	Thu, 02 Jul 2026 07:31:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wfBtI-0004HX-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 07:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+ijDypNty0/TeiekgDrrpIqxObZzPGfiCYiiEMG4e/c=; b=RZxQws+TDIJUWLKvyl9Krd+snp
 0N7DQ/sW8GnioQgo2j0mSydNYzgkTK8N8b8aVealh6tRXVsri07uMWmwo5osqQ0nSVGObMjEYc3kL
 E39/WdToGEs0l1o9J4jRgtez8VeKDcFOS4sOeDNgQhg5H5BEkL26sNt4AoNmJM7zTY/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+ijDypNty0/TeiekgDrrpIqxObZzPGfiCYiiEMG4e/c=; b=UZMyEdzYVXa8bR2JMSNSNAo8HB
 vRLaO8XGRUsLcNJsIEySTV+FWY6YY+n1M6qBACiZbBynHjCsOpmx6eKnpJdlW2ZSE9sS6mVLpIVi8
 q9qu2ZFPHPRcIhl9nbVa8xUbPhqPS7QSPXg3FUltnp+ZC3VP9zH1KBsCkRCRJfUAVGoc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfBtF-0004FG-Na for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 07:31:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 814A66001D;
 Thu,  2 Jul 2026 07:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E641F000E9;
 Thu,  2 Jul 2026 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977467;
 bh=+ijDypNty0/TeiekgDrrpIqxObZzPGfiCYiiEMG4e/c=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=cbwqN2A+KilnsiHdSeZ4WgPq3U0imwQjl4OEHQPlYCM0fLFFiBdBHQte7oZ1FmlAg
 xZGjcgsocxblP0v4j8z+u28dD4eFYv9+DLbhf+bSB3+ksagZPzTuj3Hi5/VQyysAH5
 f9wvpyTm/NJ2quoP5soaM3PpTtFjbdkkeDzd4VcUe6le7kxMQnGHbuiIprcMD8kX5M
 kHzw7cZXNYzJH5CbfhSIv5aRyWZpDpXahz1Umf9amkrNefxGR9Y9Ll9cLxmSLCm5hO
 F9sWExnsajzBu1ybBnkZ663Md6Yc58mdDod5yTKgvA4FIwQUG6vXW8rkCUQ21cK6yc
 KOrO0qB5azBBQ==
Message-ID: <e241092f-1634-47d3-befd-00fbd4a65706@kernel.org>
Date: Thu, 2 Jul 2026 15:31:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260702065602.4120914-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260702065602.4120914-1-jaegeuk@kernel.org>
X-Headers-End: 1wfBtF-0004FG-Na
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs-tools: Build f2fs-tools with
 _FILE_OFFSET_BITS=64
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
Cc: "xiuhong.wang" <xiuhong.wang@unisoc.com>,
 Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/2/26 14:56, Jaegeuk Kim via Linux-f2fs-devel wrote:
> From: "xiuhong.wang" <xiuhong.wang@unisoc.com>
> 
> After commit b15b6cc56ac7("f2fs-tools: convert to lseek() and kill
> lseek64"), 32-bit Android should also be built with
> _FILE_OFFSET_BITS=64.
> 
> When calling the lseek function on arm32, if the offset exceeds 32
> bits, lseek fails. Therefore, the flag _FILE_OFFSET_BITS=64 is
> added to support operations with offsets greater than 32 bits on
> arm32.
> 
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
