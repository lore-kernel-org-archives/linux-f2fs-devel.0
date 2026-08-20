Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F7DC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5Xu1iVc90BC4dr/6lX5XHFbQdbb5lm5JOab+4xwsRo=; b=A9ysE8HghhjQ8lcrJ20Sh70m5t
	HkVNXFOW4NfL623apggNVL3o878FeCS7dFhIDyKdotOSZu9T+zecFvsMwa9infBWW6iZT/sjQZVxN
	1eoW5eQ21xW563T59qLlmyJmjIK7HcbOdCTZWcHfMajUBlfYoijT8TZJ3kTCKKBkd2UI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxCeb-0001gW-UZ;
	Thu, 20 Aug 2026 23:58:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxCeW-0001gK-9M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 23:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Bcuvsj5+kPR+WToJ/zyp+G13hKZKfEiBz70wMjSQCA=; b=jmcnUxVGwUaGjgpenuOWhKteKm
 UPYp6WZiVrbIyeEVy8GfOFtfVd8DFoujcmezMjwHRpMtpALtYGl0CzqmKuGsNlK/BEEHAzDtcsVZo
 fRah1uhmJ9tOq5nvlRbn64OzyE7Ulcc9YjSgHIAO5OqRp5eAP63kWxmB2tWr0FBHGRNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7Bcuvsj5+kPR+WToJ/zyp+G13hKZKfEiBz70wMjSQCA=; b=Q7+jvN68oK9B9mI1YqaEHIcvgx
 IXyeuzGRNsrf1EHnbgBHDtd5o7/EelIuCCbXFSSumcxLkSTHm9i/w5yiZRzKDlRMVhXbz7e94lwB/
 4bNrdJrcAVha7gSSCBk4aGgVuNX5DqJrHUxVbe26FAIgmD4STnkCVIWlOfIIcHs20ulg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxCeW-0006Zp-JB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 23:58:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48AB140D65;
 Thu, 20 Aug 2026 23:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127851F00A3A;
 Thu, 20 Aug 2026 23:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787270307;
 bh=7Bcuvsj5+kPR+WToJ/zyp+G13hKZKfEiBz70wMjSQCA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TCDvbQKtwbbC85ws/mVMrXCCkrfYGDE9VHaDyjUIN0wXybjqZvx95ImZLFfpyilZY
 Mwg3sENECGRAliImndQ9peeM+4qVHf39dhMrACzFGJlahhPXsX46IvAWcZJohQ8ZpV
 hKh4K4xY5x1RQKkNUaZimZpU14M9Dyw2XHj0Uk419eVgNXla0QYaMC171QrgXKFd7o
 fKYCqIuD0GlOwPWUEryPhwilGM0Pl37d2BlS84y1Fwdy+U28afhPWRjB61ZR1ZO6ZU
 uBDfX65YFKT441QlioFuu9ryWYGD3q4jP3+kwRwoKznUY4p3apTX7RMNNPiSgBfrEM
 IjpgDL2+/LvzQ==
Message-ID: <cdaf6561-e14c-4790-9da5-c7821d3d446b@kernel.org>
Date: Fri, 21 Aug 2026 07:58:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260820211641.1273552-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260820211641.1273552-1-daeho43@gmail.com>
X-Headers-End: 1wxCeW-0006Zp-JB
Subject: Re: [f2fs-dev] [PATCH v8] f2fs: support dynamic reserve/release for
 device aliasing
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/21/26 05:16, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This patch adds a dynamic management feature to the existing device
> aliasing functionality. It allows users to dynamically reserve or
> release specific devices from the filesystem's free pool at runtime
> through new ioctls.
> 
> To support this, three new ioctls are introduced:
> - F2FS_IOC_RESERVE_DEV_ALIAS: This reclaims the space occupied by a
>    device aliasing file. It first performs a capacity check, resets GC
>    victim information for the target range, marks the segments as in-use
>    to prevent new allocations, and then triggers GC to migrate existing
>    valid data out of the range. Finally, it reserves these blocks in the
>    SIT to effectively exclude the device from the usable capacity.
> 
> - F2FS_IOC_RELEASE_DEV_ALIAS: This releases the reserved space of a
>    previously reserved device aliasing file. It truncates the blocks
>    associated with the file, which makes them available for general
>    filesystem allocation again.
> 
> - F2FS_IOC_GET_DEV_ALIAS_STATUS: This retrieves the current aliasing
>    status of a device aliasing file, returning whether the file is
>    released (inactive alias) or reserved (active alias, with blocks
>    fully allocated on the device).
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
> v8: fixed device aliasing checks in f2fs_rename and f2fs_unlink.

The fix looks good to me, let me skip to reply w/ RVB since the patch
has already had it.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
