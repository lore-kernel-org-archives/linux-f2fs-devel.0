Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC008C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Apr 2022 20:28:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nfSYU-0008TY-Rb; Fri, 15 Apr 2022 20:28:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nfSYT-0008RH-H5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Apr 2022 20:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jkSebVqJ9cGGOw0C+fiu30frTIAFTjDc+dhhxF5z3OA=; b=F/eUNFWf1iQ6h1eq/BoRg1V32j
 GfMi4k6XhAoHHsk9yrKYX9QAH/k8KTUnsP4swCwp6nQ88GlskVKlUlaLPIvKfVKTX3gHwtnLdJKeg
 VfTKoUINuP6h3+mVvKS0pGKLTVJPpDS6uaTpDjl+/1zPj7PzV5t/EiW5+2sG0ibjD57k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jkSebVqJ9cGGOw0C+fiu30frTIAFTjDc+dhhxF5z3OA=; b=WK09H4XCNEJ3QVOFhTfK8LShD2
 JRPxP9Oj+HE/pggMFBQGnG11bhuQyli2rgoeIh4jpBVy3itsjxmCev8q4AEJvykJuPmRVStuhhme4
 TDJgOxVy2QuOCdAdQf5kXT4tT+zjr7eHHCa9g8rE73PFsbHkxybYRVPzN53M4meiclG8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nfSYQ-000epT-Q4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Apr 2022 20:28:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C438661F15;
 Fri, 15 Apr 2022 20:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F91C385A4;
 Fri, 15 Apr 2022 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650054499;
 bh=5LhCldaKUglJbfoWnEQxZzw+7Zmu3f9fJ46Dxq5veQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gVDLpEtc/GTYhd8fugVuHefpB+lgG4aazDY3FeL0jHIUXwc8T3QDeqjq0fBcgYcSQ
 DrGJ+YnEv8Fr/CW4Y5qw9n80ZYIR7B3sNP/0k50Husd2kTiEAhZC+rwdJnE3cYAfkM
 6GaTYE8zEccEfJSbz5rS8GVATfwl4n+EFYtXX0ZiPXdO8MC2+I2vdNjFJl0JoAn8sH
 qOoOJonCvYOBDBWZLIVjC/i1ArC8etnHObYQurMKLjG9yurB6A0GuAVwjn13pAGMiO
 LUe0VCQgk94PUzXnpu/jlMsyJngKXRFyGCdXlS2oEJadRq5xgYvb+ozuUNI6Jk40DX
 6TL0x6N71KVHQ==
Date: Fri, 15 Apr 2022 13:28:17 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YlnVYb34gNtFcQzt@google.com>
References: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
 <dc6e857f-68bd-2028-35cb-ebb34d5facba@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc6e857f-68bd-2028-35cb-ebb34d5facba@kernel.org>
X-Headers-End: 1nfSYQ-000epT-Q4
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix signedness bugs in
 f2fs_gc_pinned_control functions
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/15, Chao Yu wrote:
> On 2022/4/15 16:49, Jiapeng Chong wrote:
> > Fix the following smatch warning:
> > 
> > fs/f2fs/gc.c:688 f2fs_gc_pinned_control() warn: signedness bug returning
> > '(-16)'.
> 
> Oops, thanks for catching this...
> 
> It's better to merge this patch into original patch, if you don't mind?

Applied.

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
