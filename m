Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CCCC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Apr 2022 09:40:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1neD0w-0005w9-GD; Tue, 12 Apr 2022 09:40:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1neD0u-0005w2-JT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Apr 2022 09:40:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8dmGFBQS0HMoMJqGsFG7a7SIAeW+th5F8DHc4bVprAE=; b=E3bwUGq5u3vsFypFRGyR9dzttP
 NoCmUood/eImAovJKL5eJfdGJ67yQ9+HiDazIq+NTB3/DSp4HJoYW5WIV0sFoXsuk9gicg2QzWa7x
 bzF6z2DVbNSBHeHgAmfAM+RTezqi+4vtkUI0+QlnyhB1vpcpw/qFnMV1/BkAjFhMcRTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8dmGFBQS0HMoMJqGsFG7a7SIAeW+th5F8DHc4bVprAE=; b=RXQWitl/xHx6azcLvEkPcUMUeH
 I/V4+ls3A/qOTDtxXhLvouVa2tBiR0jXs5FFmbd/680mDh+AQhsp43kUjv+jfbnZF6BZBvkLlTbuF
 tWmlXn++gqATiHtFY7XI+SWdE5OQ3trJlOB45X95fHl1kKbFL01rjYOfhbur3+KdX6Rc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1neD0t-0002nj-Sn
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Apr 2022 09:40:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9B5D9CE1AD2;
 Tue, 12 Apr 2022 09:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6226C385A5;
 Tue, 12 Apr 2022 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649756433;
 bh=jVAiChky5XX869hnpykLtLDYrh8c1aa/BDWMt3amk14=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g8d6E3SHmnIbwDRuBR0k95nVWyQ+FaHlxYfPG31jWnLLSolp05CdsBP9e9VpmBYRM
 4K+plM2+vmPAGGDIy89SkpCtCoQ/5AW2324yq2wX+hwKMT45FRslo8TCK0z6qPFsXu
 efFdZrGUb/fd+OQpIfZ8XP5dG+jR8yadnBc4PNMfP4iU+A8RrFdPePlYK93lsg0sZk
 7HCyXWDBtRLfP6cBrGEWdiwItYBcyp1N0dbjeXMH1WBe/CEOn0gJK524UOqSIEAbzW
 dpC4ITvNriWYnrx8wBxrTmNfIY92/jT4zJiXF0MlmdZtwHosy660VsV52GpMgdxJav
 RagKazrobyMag==
Message-ID: <4d54f494-b143-8885-a31e-924a83409e2d@kernel.org>
Date: Tue, 12 Apr 2022 17:40:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jakob Koschel <jakobkoschel@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220331221650.891790-1-jakobkoschel@gmail.com>
X-Headers-End: 1neD0t-0002nj-Sn
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: use separate list iterator
 variable to call list_move_tail()
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
Cc: linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>,
 linux-f2fs-devel@lists.sourceforge.net, Mike Rapoport <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/4/1 6:16, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element
> [1].
> 
> If no break is hit or the list is empty, 'next' will be NULL and
> list_move_tail() should be called explicitly on the head directly.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   fs/f2fs/segment.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 22dfeb991529..81ef2c3d08e5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4175,16 +4175,20 @@ static void release_sit_entry_set(struct sit_entry_set *ses)
>   static void adjust_sit_entry_set(struct sit_entry_set *ses,
>   						struct list_head *head)
>   {
> -	struct sit_entry_set *next = ses;
> +	struct sit_entry_set *next = NULL, *iter = ses;
>   
>   	if (list_is_last(&ses->set_list, head))
>   		return;
>   
> -	list_for_each_entry_continue(next, head, set_list)
> -		if (ses->entry_cnt <= next->entry_cnt)
> +	list_for_each_entry_continue(iter, head, set_list)
> +		if (ses->entry_cnt <= iter->entry_cnt) {
> +			next = iter;
> +			list_move_tail(&ses->set_list, &iter->set_list);
>   			break;

return;

> +		}
>   
> -	list_move_tail(&ses->set_list, &next->set_list);
> +	if (!next)
> +		list_move_tail(&ses->set_list, head);

list_move_tail(&ses->set_list, head);

Then we don't need @next variable, right?

Thanks,

>   }
>   
>   static void add_sit_entry(unsigned int segno, struct list_head *head)
> 
> base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
