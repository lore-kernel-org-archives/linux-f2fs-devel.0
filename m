Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F389FC636D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Jan 2023 03:40:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMhVf-0001cf-Ay;
	Tue, 31 Jan 2023 03:40:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pMhVe-0001cZ-Me
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 03:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dzCpyvhDcYxUTtn5JQeRgbDiIhoJOBItkn37AahSrkY=; b=Ig7fdkExQSU620TvO7+6b243kJ
 tOeNwtZvfEWMpwE2AmLGzeuf2XILPYAzmcGjo7GlZU1qmKc2Mb2Ajax9B7SS8C4lFj48GqQdMaWJ8
 W3xLPCENtHeQWUWFYy3Zl47G0qxdptP/a7Kp2DIoSRsUr1L8Agcd66lZu4Z7SM8DdOWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dzCpyvhDcYxUTtn5JQeRgbDiIhoJOBItkn37AahSrkY=; b=eN0ta7PdX0X/UOJjVdQpPqCfUR
 Byt+xn6QHtDD/f8Txdc3NbhwIuL36J/ryp+xm9n4LVw9vStubZQwm6UCa9Fx3XFVAf0zEJObGt90C
 d+x1F3dixpJIuTbJ8Rj6IipMV2Z70x6qwGzTZP/7jAm5cHmKg00QvNvduR34r7HXjTxs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMhVd-004eHy-Bz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 03:40:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 18E63B80687
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 03:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CE5C433EF;
 Tue, 31 Jan 2023 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675136429;
 bh=L2PPKM923+y7/eYTbfR//3FC74N9z7G/ocwdtowlJ08=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X8QuLPz2WYQxsasqvLqfcWE6eaUksDpDdrCALfmQHGQn6DTm1ZiKsdwcCPhG+gx9j
 zufiGNGldUXAkHnInzew1YrNy8A412H44/nvVH9TRq7kP69QXV06CxHXb3NQjExCF/
 9cl9ISeZeBKCXaCD8BHpYn8fVDIJ7FW4xEvZOxaWs1crE3n4HpuS2KvePYuiTyd85k
 sdZTiGh/O/v9Njti2S09cCMaPE8dt+uPdXeB+QqCHCLVBDfRUYIMammv0MGyUEVskj
 pcr+aAVK07l08mK21XV2nem0877ql8ZI/rdJ6+AYhmuIA5pRvjLH1nwS+1q6qVIGjR
 G6IytFttAY8qQ==
Message-ID: <bf23cd40-34b4-de51-8dd7-c3d0ac1f4a94@kernel.org>
Date: Tue, 31 Jan 2023 11:40:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230105233908.1030651-1-jaegeuk@kernel.org>
 <Y74O+5SklijYqMU1@google.com> <Y9hTCtWLo9/PQnnN@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y9hTCtWLo9/PQnnN@google.com>
X-Headers-End: 1pMhVd-004eHy-Bz
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: retry to update the inode page
 given EIO
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

On 2023/1/31 7:30, Jaegeuk Kim wrote:
> If the storage gives a corrupted node block due to short power failure and
> reset, f2fs stops the entire operations by setting the checkpoint failure flag.
> 
> Let's give more chances to live by re-issuing IOs for a while in such critical
> path.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Randall Huang <huangrandall@google.com>
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
