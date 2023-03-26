Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CFFC74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 03:50:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgHOd-00061z-UU;
	Sun, 26 Mar 2023 03:50:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pgHOc-00061t-T6
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 03:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PvGY4SNVI7V4cRFGDllLJhby95oJSC1xX3SIsYpmFoo=; b=C/f1tvvA+yvt5Qj010RK+8FCOi
 QSQpDDFLZ9sSq37yny4Ig1fs4kwp1akFWJxvePugE5i77ee5N3H/F7bnYaZXIMbMyhDerKoDbvZlf
 vmWkTSCzo6gIAPJafk/r13tIYOQtN9E33fSWOol0QQZ1NzRe0E4idowXrdIoiNPJqWro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PvGY4SNVI7V4cRFGDllLJhby95oJSC1xX3SIsYpmFoo=; b=QrkGaywzXxcz9o5uR0Tl8FBOfY
 EJ7TzfSByjHewtLsPAc2zmg46DPzku4vK85/dLzsN04hi7o94Bbz547m5oFDJDIgMP5IYCV5yB2Kf
 /LHxsnvzQgxrndZHGWRS7H3n0I5dbUH5IS2FLaQRml08oY2YnXXiCKofOwbQy42TLoPE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgHOb-003pXp-A7 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 03:50:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DDE0E6068C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Mar 2023 03:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61959C433EF;
 Sun, 26 Mar 2023 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679802611;
 bh=LAvyz1060gPts0GjgiePob4/2gg+XoL6lIGQJ0eqymE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oMdWRUCI7vyRF/7sNx7BmpUPSljpIETnIY4NiA5GAzheECGpBk25/7+7o5295RqXN
 DblR5G3MGypfWmRuNjyyW29ieZeuOK8s4oDNEJYfnjGpn61Sg5iptF+dDdYLBF5R5W
 ZlOfd2KgN0PjDV1hrQHIhuq89CVpyEOnVrdwQ7u5ohISUNrHYV3rJT8FWu8r/U6hwl
 q/KVL3UcaUzN4Gz3QXU17b+Rd5QA/1c/t1cRSp9dUy0sBwIpuxcTWpwuxtz4joAXus
 IZwYJf53Mesk3Mu75e3lP5ytIdTQItjZ1xGlCjvSqI/Z0N71cwXwkogfC18PXqhcVk
 84vpePlJe7rUg==
Message-ID: <c6a70066-6b23-a1a0-1762-d4b740af1283@kernel.org>
Date: Sun, 26 Mar 2023 11:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230313201216.924234-1-jaegeuk@kernel.org>
 <20230313201216.924234-3-jaegeuk@kernel.org> <ZB3Wc6jdbvLiZNl5@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZB3Wc6jdbvLiZNl5@google.com>
X-Headers-End: 1pgHOb-003pXp-A7
Subject: Re: [f2fs-dev] [PATCH 2/3 v2] f2fs: factor out discard_cmd usage
 from general rb_tree use
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/25 0:57, Jaegeuk Kim wrote:
> This is a second part to remove the mixed use of rb_tree in discard_cmd from
> extent_cache.
> 
> This should also fix arm32 memory alignment issue caused by shared rb_entry.
> 
> [struct discard_cmd]               [struct rb_entry]
> [0] struct rb_node rb_node;        [0] struct rb_node rb_node;
>    union {                              union {
>      struct {                             struct {
> [16]  block_t lstart;              [12]    unsigned int ofs;
>        block_t len;                         unsigned int len;
>                                           };
>                                           unsigned long long key;
>                                         } __packed;
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 004b68621897 ("f2fs: use rb-tree to track pending discard commands")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
