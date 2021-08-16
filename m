Return-Path: <SRS0=ksoz=NH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F24C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Aug 2021 02:37:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B597C613CF;
	Mon, 16 Aug 2021 02:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B597C613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFSVf-00030O-S5; Mon, 16 Aug 2021 02:37:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mFSVf-00030I-2I
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 02:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8x+g2ha9ik4Vgy3+UW2RYKLfsxqik39pgGC8FWWjP6o=; b=lt5pTeTHeKQA1zl0c47dzlfwDZ
 H6Q/9lfM65tNWhLbpaAuzWRzLFDJOXagzCkt5dAkh6nbVc9fKVVYW6/1xUoohC+PS/iEx9rAUxIyF
 Qk6sXEmgvXbw67G8akcPB4e4k0zOi5JqR+32vnIcrwC+12+6LmmahFFgyAf82GANSnHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8x+g2ha9ik4Vgy3+UW2RYKLfsxqik39pgGC8FWWjP6o=; b=E3SkeYfz9buj4UJ/luimnLSgzU
 uKE+pGArRFHBIwtdkFxqu8vgJhiDWk0JRdq4jjdH9RkBXoE8s6WelcSWflFHAGR6wuXFLyIITc9C/
 J20i2BYt8L7l+8XRGoLtu/ZBJ0AmYPu4aUBUhY78KHVbk8zDk0/yIVmipb1aXVP9oSno=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFSVd-0002sV-Mp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 02:37:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C5386142A;
 Mon, 16 Aug 2021 02:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629081468;
 bh=8x+g2ha9ik4Vgy3+UW2RYKLfsxqik39pgGC8FWWjP6o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ruaLrpfV3CVut1lGYP3YkImXbdMcb/OC5RPArUr+daWUt0Y49OOMKhoWzdeGWawso
 tiGMtEFgHGG9sU084D8mOVIZlt/2TmJut6zIvgprx0DujIT2IBOYdVK0UlAqqB8rXE
 aIJT/ei/ndGdRjuQSFmEv0wipJkvpBj3YeVFaCmaT+5uAF+ZBOjnr7mYm90z6Fb+be
 LrgTzMrXbhtIX52CdzGNH4z8hO+1fOui/xOwklAVCOD55IhHEdx2ICMYmiiEDnWkYU
 8hh8DFUo1tuNsyKLlylD8nitCjqizspr749TuLZZUQ3ByIRkbT6FVQUtZczlSqFOJ9
 cB5bIwyDIgzSQ==
To: Daeho Jeong <daeho43@gmail.com>
References: <20210803225542.3487172-1-daeho43@gmail.com>
 <2a79c1c5-366b-92d9-4025-dbda660b1178@kernel.org>
 <YRWKKQe0bcgjKIIA@google.com>
 <b1a7b8a6-89dc-9076-2388-ced59aa8c47c@kernel.org>
 <YRbARsMfs2O2fz2s@google.com>
 <b76b5b09-d806-992b-3256-fe7ebfc4a2df@kernel.org>
 <CACOAw_zTAFfQGqRVRADq_dyO-Rf++Sn+uhwJZ+4MHv4rPwozCw@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <ceaed49c-9e7b-3d14-a540-28d5382b672b@kernel.org>
Date: Mon, 16 Aug 2021 10:37:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_zTAFfQGqRVRADq_dyO-Rf++Sn+uhwJZ+4MHv4rPwozCw@mail.gmail.com>
Content-Language: en-US
X-Headers-End: 1mFSVd-0002sV-Mp
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce periodic iostat io
 latency traces
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/15 12:27, Daeho Jeong wrote:
> Actually, I was working on it, after Chao pointed it out.:)
> Merging them into F2FS_IOST and separating it from other files looks better.

Cool, :)

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
