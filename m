Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF466C624DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ms+LD6M4xRgW8IU5Of7iAX2sfwB4yz1SmeJKbrfw1rw=; b=GKm0zGkDMhPXQuJSwTvER2EQKh
	5qQXk3Q8UY/nRwACCZ5wrQN4SObYxv4/thevCvfC13alnM+jvX9SToHlc2kyHyhnI0t2eeD53cYiG
	KoDTcMN9bOEK6DDA2ktL2MD3Bq72YTmQhHj5XPxzR7Ja4k6ktOiyJ5j/ZeVvdZPYeaEE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JT5-0004rm-Q1;
	Fri, 04 Sep 2026 02:15:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JT3-0004rf-TA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TGpc85ZmL7Rumy/c7HrWsK71idv1/TYxsvl542ShOPI=; b=fIHNPBfHOGFz6k06B7UK74CZFp
 scdALoSQL1CFQdv+W8MTR9Yg6DnYUxU+QKp7DRKjLfdinZCmJlNPOf0jaZI1NQUawBGGky8MOCvBH
 SbnMJkCHjFMsKL8UoD4PzIXsAe4Wqb1a7TJI7geBgk/mCA46bZUdFz9CRB0cjkWTqGF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TGpc85ZmL7Rumy/c7HrWsK71idv1/TYxsvl542ShOPI=; b=hNzXebc6i7UcWUGezyk+HuUdjl
 w8BVBVARyA6IATToRMeq5Du/+aEY+fr7F3EG0p4pfRlvNG/BZRuOycTNJ72dJACnVWPE1296Cbpil
 UeU+EtpMRnDcxdBr8mVEvZEM2rddRzAfHSYO7su4Mv7lzRs0ruaCczGG9napycwV8bWk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JT0-0005h9-UA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:15:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28E3C60234;
 Fri,  4 Sep 2026 02:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871211F000E9;
 Fri,  4 Sep 2026 02:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788488140;
 bh=TGpc85ZmL7Rumy/c7HrWsK71idv1/TYxsvl542ShOPI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=NdM8SVsLClnOeDdnodVRrwGf6ah7Ov9ggd1UmD0mT+nf9MpN7kCLf57pQ+d3T7TY9
 w0q9itrzPREtsm34ThHC+NKakuKLFRbMPrNYyqmaw7ldYzVIwnGHiGiigW2SAc2X22
 ofGNCLGOX8lxIWQt5UA2jXrmBSIByHGb7MwEaagppYd1PPc1UEeqmUHwXQZg1tkGs5
 JQU2xF2tnvpQb52a+I6ZWObA8uvpd7k5FevLhwZD8ZvG/ZJpy0aDs6xjebAu+cGBhX
 089jf/KFIR3kVes5/J38UGcq8DZx4eOaccNOIsId6zFweCWtBTmD3NzxcekTwYBlRH
 wJuitvkBUcCpw==
Message-ID: <e179d20c-4ba7-46dd-8835-29ba00247998@kernel.org>
Date: Fri, 4 Sep 2026 10:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <c7005ebefcad46d6a0bf3b0653fbd3692b86a360.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <c7005ebefcad46d6a0bf3b0653fbd3692b86a360.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JT0-0005h9-UA
Subject: Re: [f2fs-dev] [PATCH v9 07/11] f2fs: describe xattr block layout
 dynamically
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> The usable capacity of dedicated on-disk extended attribute blocks and
> inline xattr regions scales with the filesystem block size.
> 
> Parameterize VALID_XATTR_BLOCK_SIZE and MAX_INLINE_XATTR_SIZE to
> calculate usable xattr limits dynamically from sbi->blocksize rather than
> hardcoding PAGE_SIZE or DEF_ADDRS_PER_INODE.
> 
> Update mount option consistency validation for inline_xattr_size to
> evaluate allowed boundaries dynamically against the runtime block size.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
