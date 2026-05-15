Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA64CD4F3C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 04:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o70+933e75Z7n1KqB6KFXliLEz+7Eet+3C7s0PZ6GrI=; b=UgEs4l9nGmSq9rel5rtWaLuAz4
	+iXLwOQqw7wLLctltrvKAxBhYkO6WqHrQ6lWHFnHymhCSE8LmaHu9SPIVUHo+/vxLy5KS/SUB0NN1
	wMQm2OhqUo0TSb0iwcEJHoVoRMezZ37IrM2Mk7GnfYqagufg5swzDGc9S4Q/tvsTusOA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNk38-0002Sh-DG;
	Fri, 15 May 2026 04:21:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wNk36-0002SY-Qm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 04:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bgild9W6sAfFiZTYavMN7lG6MtP1atp8KizVP+A4w+w=; b=cvUYz+YrfUI4ClLf6SVcWRCEAc
 BwgPNHQ1oIqlHkrVxu2RW53AO4ovQezKK+xgkhLLqFXOHrv7Puut0aW3Ctc4V/kyGF5CwSxtD1VEs
 NF8CuGmBgcxU30vUQC7d9aTT2MjA118VSrlelmanBzXC9sYCGrQgjhccvGKh7SrpW8ZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Bgild9W6sAfFiZTYavMN7lG6MtP1atp8KizVP+A4w+w=; b=lGt4IpkARBUqavPRI1X2kT7O86
 tHfjKAl7wBnMVks+zCyw/X6DHo6/3jrxvRvknpm988e2wQ39NFUSiTkH5lUWReUh1GWzwTl+g0AfJ
 F+s+OjO2PIvEJH8eSll3CFLumS+la9OXCrhRIX+H6/lQdJWWAcccMi7WwAlh0muxWrWA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNk35-00016E-Lc for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 04:21:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7464D60008;
 Fri, 15 May 2026 04:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FBCC2BCB0;
 Fri, 15 May 2026 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778818874;
 bh=hzpbGtt5JNjh+2XBoTTDm/pYECTztJwQwqxX8PEVhBM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bKV9axnKW3Cc6MWDsucuNgq6+/Jh6Mt2Ax6tMrNcS3lwNimU+2vXlXtpT+H7DFFbJ
 uB2/iL4IUVd4r6YCrgMXPxMcmdjyzyvrJh29294+YQMkX2OjwE9iDnjXaVKCISp0jf
 yU0QnnGJu270NpqilE5mKCGtqIZeNzhdL5ZiSBjyZIurCJ9ONl3ChrWw5kgNHJiSK3
 M4yOVMWg64z9o2f9sUcHwXwJgNkUe0dO2CIG3IoyyhBxuQCseKyra6pgrfHhC8SDFU
 WMvitvWbs/B6vVmGJi5Z+r+ug1zPUbxz2fuJVaqW8av/i4Bjx+4g2kB/wDpecUDQcX
 Q9aCUcFFj2w/A==
Message-ID: <1d069492-b9ae-4ec9-9eb8-c77f6de3ab29@kernel.org>
Date: Fri, 15 May 2026 04:21:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260513032009.2300435-1-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20260513032009.2300435-1-joannechien@google.com>
X-Headers-End: 1wNk35-00016E-Lc
Subject: Re: [f2fs-dev] [PATCH v1 1/2] f2fs/015: Fix mount syntax for
 disabling jquota
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/13/26 03:20, Joanne Chang wrote:
> F2FS has removed the trailing "=" in the mount options for disabling
> user, group, and project journaled quotas. To maintain compatibility,
> update the test cases in f2fs/015 to try the new syntax first, and fall
> back to the legacy syntax if the initial mount attempt fails.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
