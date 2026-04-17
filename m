Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F2EF8E4B6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vmqc2Dgsrwm64VRSVWqKdiiNgjB7Urjp8UYVor/36ac=; b=LiZPvhw47BzNYO08/L48JEJQQ/
	3YQ3xHhRHYm2uYqoTc5exAgjAoQNGT0dYLxqz3Uxiwpiwu0MlH/PkkfIU8DuVee6k7e4iJGJ/Sc2+
	1g4I+gnGWX8APEV4ZGLQMDFT6XuSbs4UkVx441dryOkIOPMPOINxKnFkI4v4yO+4KH1o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDdrO-0004bQ-8H;
	Fri, 17 Apr 2026 07:43:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wDdrM-0004bC-Ny
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 07:43:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fwuxe5U+P47cjhNqWO4PmETcScamsS7sP+9A7TzfZHQ=; b=fHMYe4xp1+y6K5WalL5XOHIQ7o
 zk9nlqwkHxDMZnMgjxy/oZsvOjj4hhvdc1FiB0IjM4ecM7NxRAeQY73x8D/kYDEXFMhEIbXvIUKMo
 PK/i7cBGc6WjXFuEqJ9yJfHM/e3MD4vE7fa1sb/objkU6zcdpVfEsBLa5zKSddVNO25U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fwuxe5U+P47cjhNqWO4PmETcScamsS7sP+9A7TzfZHQ=; b=lI6+cBE8qAnAlsjSI6p5P+GAEf
 M0A73oIS2WsT2ILKbb6mVvUi3inl1ZqPlJSUO55ek1dA79G+QmIvL94Uk3MhkC2Brci/59o9o0BbX
 tK1DbCMy/9qaNGl59YlStl0JvPyCh3xnlecI/xJzVX9s5krHD3BAJL8IG3Xga3+aRBrQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDdrN-00015Z-4I for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 07:43:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D3AFA43784;
 Fri, 17 Apr 2026 07:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D8C19425;
 Fri, 17 Apr 2026 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776411798;
 bh=XlYDh6hpbtr+nL+qQscuosqfKff4KUibm7ZfBnxFq7Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=qgwomOeRhss89lwMQnnp1F0mUE0VvlvFAY+Dx0ZONbVuq99z866u8f9OwaNL/1Ugb
 4flExBoYXNuj3buVQ/xW0QF9+AmieIxysVcXAzhlUWnfy0z9KH6/z3wA9Xi/77crqJ
 uk5Ucu2KmjM1hXgghEsI0iH6AScgO0ViJbqdoVxj6ICz+w7Rk/6UNQ1TKiiX1UEAV1
 UOvdTzDMiYADsMgEkEOPiitkjELuQVvdMcmbmuqTxz1kfBufRTVXV5gghswOYwBThB
 VDwD8ljl1ppiOlFj7PXAfyxS6zDpkYL5hrCigBRS4NFBqL82ZSv6/IEV4BydO1XSYb
 5cy8ovCRAkp7w==
Message-ID: <9d1c9ac7-44c7-4e7f-bbdf-b839f6f292b1@kernel.org>
Date: Fri, 17 Apr 2026 15:43:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260415114237.3089952-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260415114237.3089952-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wDdrN-00015Z-4I
Subject: Re: [f2fs-dev] [PATCH] [PATCH v2] f2fs: Add trace_f2fs_fault_report
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
Cc: shengyong1 <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/15/2026 7:42 PM, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Add trace_f2fs_fault_report to trigger reporting upon f2fs_bug_on,
> need_fsck, stop_checkpoint, and handle_eio. Since f2fs_bug_on and
> need_fsck can be triggered in hundreds of scenarios, define set_sbi_flag
> as a macro to help capture the effective fault function and line number.
> 
> Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
