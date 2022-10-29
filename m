Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5333AC38A02
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Oct 2022 02:56:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ooc1R-0006HC-Ua;
	Sat, 29 Oct 2022 02:56:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ooc1Q-0006H6-Np
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Oct 2022 02:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QB+529rpyJFpRGYVvz+gzeLlU8hEll899ZGUJifP2m0=; b=TcqFkZljUN6zKDIxXVcDMz8zdN
 PKPvXGjxqYaYqgVOgGtKygrieeP0dy/3AxKK2ldLJ1oy2Pa2i0PKF0WKYNLmysw98JzbP8N+9d9Qd
 lQvBBshF6n5iYbCCAlM5UWAKUJJ5zppbrZuMTeNS1qRU51zE+ySjBAcE9M7GK7OMbvnc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QB+529rpyJFpRGYVvz+gzeLlU8hEll899ZGUJifP2m0=; b=B/tZD84vSl65Kquymn7zgHl6yL
 /Z+7JpH5Mm4jNMTbJyWWMaOy48SiarKc96RS+6AZzWuoQgGCxWaEPBoibmfVSZNc+Daz6eGx/l3UL
 OqUEI6umaWq+mIM4huIcko/2qr3D9RV/8FASmrvWKnd8Zvk/xt7aXx6uJtsgE2Ags654=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ooc1L-0001Kh-CG for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Oct 2022 02:56:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1F1FEB82DFD;
 Sat, 29 Oct 2022 02:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC577C433D6;
 Sat, 29 Oct 2022 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667012179;
 bh=FE4pQKEIZlmevs+ZupCbUJ5veYZf1bpoqhRwXjXFKjg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=AMxiismJPYdb46P+jKLp8h2AZVErGb9zG4MND7DQHEo3HdB8aUw3HZplIpzE/ku2a
 hAyARLG6fmMQus22Uw7lO1B/+fjouRmT7Lzt5kt35cz8vX/n5tco/4+nfs7jatVC24
 1EwKJepY1vkL6BYu6sF1EOzTGxUFT3iLBLSayN4ihDOpM9Est+kQV+xAEleZJ1ttEv
 PJevhRSq3zeSeja7jBEO4Gn7W4AGOYNlUoaLk1Q3ywA/rUu3syDqZY3pBnr1K7LAnv
 Ty1ebWx3s+B18E6hV/BtXz+jXDIxOi6tx8WMVZgF14qmpqsu6OiZL87b604XyLnR86
 PLt/sd5Slu+1g==
Message-ID: <6b069b19-fd33-9783-e497-9499b53668f0@kernel.org>
Date: Sat, 29 Oct 2022 10:56:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: keosung.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
 <20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
X-Headers-End: 1ooc1L-0001Kh-CG
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix typo in comments
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/27 19:01, Keoseong Park wrote:
> Change "truncateion" to "truncation".
> 
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
