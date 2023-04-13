Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EABC77B6E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Apr 2023 15:33:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmyx6-0007aD-NQ;
	Thu, 13 Apr 2023 15:33:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pmyx5-0007a6-Qn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 15:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5KBMCN/OghfVXdjjt+6NWWf8nfNl7IEIrVkEbI3dp4k=; b=HB0Ofa0luJvPrrY3EHXjx3pbrh
 EQc24whHo4Cf559pReWpt7wyE2hDHdrA8DkSggML4LsmWmbtrf35kdkRIdzGkO5cvXhlHwTiJFJ1T
 /LXJ8iN9bFCrA0nmobI0BF8gd/oH83HhbHlagtMKUypMqWq2MwSccQAiosebY5pymyI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5KBMCN/OghfVXdjjt+6NWWf8nfNl7IEIrVkEbI3dp4k=; b=QahGf7JaflNUJ4geYMaUNkmICX
 p13x1LDHuu1YvSFlKNx7xuMSXIM5QgNdEacQ9th9p8OlTKk/nyxmo7wDShz07IzK7dKEmVL3YG8e6
 66Dv2ir6zIjKl7sjheJY5ARsoleE8IAsw5/LlgfGt5B6KG7zK4D19fQ1QOofq71yooeU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmyx5-0004zO-KW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 15:33:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 35CC560ACB;
 Thu, 13 Apr 2023 15:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B19C433EF;
 Thu, 13 Apr 2023 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681400009;
 bh=5KBMCN/OghfVXdjjt+6NWWf8nfNl7IEIrVkEbI3dp4k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c0FtRgpeDXzH4qTMCTgXG4mf3ccp5c7nPZDj+3ceh7JVAA44RB6wBTRt05/jPC/OR
 cLldXBZznKy2G62lR2diHFHw1MLrdfL5TN3uQBoMd+mdqlPTPi/01DF9WbfGp94Aj4
 3S9WI9vpgFh5I8Nx6J85FjpAgPBHGBpyg/l6jUhQ+8kd8Ah7i7mtUIuA+BuulHPY+N
 PhlCqLLt1eY96Uf1IKir/MNGTouUP0Bh160zSlPaEJW0xqm6lxpg+u50AFm+1XVtsA
 YTmCAYFfcXrIhu9SscO1DG9F0Hov+xNi0AckmdYsYXFHH040V9+1I46ljVd6dzXW8L
 W6bi9F6mnT9Jg==
Message-ID: <88e48f65-a68f-6742-fe25-d05e7113c2fc@kernel.org>
Date: Thu, 13 Apr 2023 23:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230412034940.41943-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230412034940.41943-1-frank.li@vivo.com>
X-Headers-End: 1pmyx5-0004zO-KW
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce F2FS_SBI_RW_ATTR macro
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/12 11:49, Yangtao Li wrote:
> For the readable and writable f2fs_attr with struct_type of F2FS_SBI type,
> let's directly use the F2FS_SBI_RW_ATTR macro.

F2FS_RW_ATTR looks more common to me.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
