Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EDDCD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrT+7WbRg4xaNG5RDhVBIPvkUL9yYndFFRxC+ER6Xs4=; b=YbzpKgfCCfYqAREzaVl9B6dONE
	Yh/ohp2WJr6QEoDrNzIYgVEqhaOyPPFnkufTGMDu7B0AnfkIujDwfywB2l7NJ+42HkZlvs4VYjU97
	k+jhmOoX8rSt/u3AdOcI0bGnnd1Z2dxLktfXQin+Dz2TARD8LsWrRNO41Bws58/wyb7I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbwmP-0004Sh-8H;
	Tue, 23 Jun 2026 08:46:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbwmN-0004S8-1x
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 08:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adywUmALuyG/Z2us7XDrWI8UlRJTGwoFilVn9pM5SKs=; b=XdNU9Q3JXwq5WiEPPSw6DIA1YM
 T7hpIu2exUBHMRW2xLcZ6EgQZWns3mMPG/mZ2Lk8fvHfa7ler/Cab5gHYIzGDdQDEVv0LGMBXwADu
 p9+DA7HkOGpd39vwK+A9ZgZ967zksUC9ModZusM8T1ONsi1nxI+MOwKgGAHu+5wlJ1zQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=adywUmALuyG/Z2us7XDrWI8UlRJTGwoFilVn9pM5SKs=; b=V/POCIj3Ni9HQmlLOVpCxwJEQd
 fJzafSE/GiIHVX19mPLvViNPRn2m7mtv2sSeZZqakN719MpXNfA8KD34/J1Iom/gmZx58B6s/pMla
 66KspLdvbmTlxZx8IyXq2Shcw3Jw2yjh5rRE6PpsXm0P+T+RttyAbrIkRQDdeVAMvQqo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbwmI-0005Xl-GQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 08:46:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A9E440199;
 Tue, 23 Jun 2026 08:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AE51F000E9;
 Tue, 23 Jun 2026 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782204392;
 bh=adywUmALuyG/Z2us7XDrWI8UlRJTGwoFilVn9pM5SKs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=V0ryzxmwF9C1X6LxvNYrcYwPCM+TpHcm/pwjjlg+RUtH97q5JkxeKhnAaFc2240KY
 UdjqFGEhUsW8dOhSe2xDrf1d8P0+eSD/LizmY6iMOo4MVUe/uwonNPh0cCkHEzgwV4
 Wtga5eJgQh7HnDGVHfzs2P6n0FcV2qy90pEsZkKLhKAAdUTm5OuwT1sUs1ytcuohg9
 8LIVjA+5bCe30Op6FaUmAjQ+19HJnljzgAOC0dEOUAtxe4DjDYcQeMx70KZTJ9LdVk
 /udP8iXBckeBfDpSuqcohO8Yzed/sXvMGVXw+wnFNYRxHxYYrQx3h8x4OsG75guq+C
 KsN9r4Sq9RnBw==
Message-ID: <698bcb3a-38d8-479a-b0e0-13d23a08743d@kernel.org>
Date: Tue, 23 Jun 2026 16:46:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org
References: <20260622070438.1542638-1-jprusakowski@google.com>
Content-Language: en-US
In-Reply-To: <20260622070438.1542638-1-jprusakowski@google.com>
X-Headers-End: 1wbwmI-0005Xl-GQ
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
Cc: jaegeuk@kernel.org, zlang@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/22/26 15:04, Jan Prusakowski via Linux-f2fs-devel wrote:
> On F2FS, generic/064 fails with "extents mismatched before = 1 after =
> 50" following multiple fcollapse (collapse range) operations.
> 
> To ensure crash consistency and checkpoint integrity, F2FS forbids
> in-place SSR (Summary Standalone Replacement) overwrites on valid
> checkpointed blocks. When collapse range shifts blocks, F2FS allocates
> new data pages in LFS mode (out-of-place log writes). As a result,
> sequential collapse range calls rewrite shifted blocks at new log
> locations, intentionally leaving the file with 50 extents.
> 
> Adjust the extent verification in generic/064 to expect exactly 50
> extents on F2FS, while preserving the strict 1-extent requirement for
> all other filesystems. Data integrity continues to be verified via byte
> comparison.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
