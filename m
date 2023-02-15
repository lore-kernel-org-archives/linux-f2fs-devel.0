Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CECC636D4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Feb 2023 15:08:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pSJOn-0006zm-5M;
	Wed, 15 Feb 2023 15:08:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pSJOl-0006zg-Kz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Feb 2023 15:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5DQIuUd1+ADx4Pb8F0E0kTsUjJP9DU/FXY67FjVd0Uk=; b=iwtYaCBfxo0IycCKK4i/9nW3w8
 ah41xSMhkWvGy9zy/TL3nln4Ev34pDIyIK0t19uGPfDcBcigk8UU7Mol6oSrkYcDJzYG33ikdmMLQ
 MPzrfg5gOYXXNfe0YTIrFnGoBx8411gXQLKO8Up+WNwGb6RRVql83oFICnikFa4UsxJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5DQIuUd1+ADx4Pb8F0E0kTsUjJP9DU/FXY67FjVd0Uk=; b=WqdRZX8UsLrXt62G0ZDCdEPNiQ
 mVIHP5LRJuXzwlGUYbzOlzKgPj6Fhy5YiqNgSUhRzDZZuvptYG/J/T4v81uhLKDGEYdN5b/pUxai3
 fTxueDsl+jSRm6s2nv9uR9V9s2kE+EIPOxclWzwhrG6h2r6N+HlqWHmfpq8m3802Ee8I=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pSJOi-0007kC-RJ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Feb 2023 15:08:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 58E82B81D06;
 Wed, 15 Feb 2023 15:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B87BC433D2;
 Wed, 15 Feb 2023 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676473714;
 bh=8+v/ksbJ9IhwSwboFHhH0kzBpXcx9X+LYE4dd6F7FxM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RfMp0Fs63+GtNKj+E0uAX7/1uI+WJTA8dhK5bI7IjW6tCDpd7PGU+3Tnb4CIrzJw5
 Gu6l7sRRzlHKQBlMeTVtLFhy68phJ5jo4AQ/pFp8mu4ids0zB5jayrcmH+YdOIkOAK
 1b408F5KrnTeb03nZri0w3qK+lwde4FA2yu3X/bmYc++3I4IO0IW7mSgYpwQ8BHXPH
 uiUMI/XjuDOaHQt76YbOZDT5x2j/6lPdUzNsOEUIpCEJw1Dt3NVP2x0/cjE0h33bFZ
 L3S6diUY3vuAxBkPnmlF7i1QuVxSSwBeP2YmfHsSuvjzNLs6Cl5cSeO01ATtDU5pES
 qTOsjVKYw63/Q==
Message-ID: <cf8937f3-6aa3-811e-c862-bb409511d8ad@kernel.org>
Date: Wed, 15 Feb 2023 23:08:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230215061701.1433-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230215061701.1433-1-frank.li@vivo.com>
X-Headers-End: 1pSJOi-0007kC-RJ
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop unnecessary arg for f2fs_ioc_*()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/2/15 14:17, Yangtao Li wrote:
> They are not used, let's remove them.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
