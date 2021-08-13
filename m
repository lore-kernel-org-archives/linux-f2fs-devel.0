Return-Path: <SRS0=A+6L=NE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6464CC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Aug 2021 01:10:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5F960E76;
	Fri, 13 Aug 2021 01:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F5F960E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mELie-00019b-Nb; Fri, 13 Aug 2021 01:10:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mELid-00019U-LK
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 01:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WIdaISNPqwn8Llsgc5HOxL21WdlzGWLzu2JU5+Qou48=; b=CghVTp/hEdH03L4mwBB8OnfmAr
 a5+waJF6ouLXSTZkrhR9B6PlyyjrRvZlaL838sQVGmDozM37HZauAPPWwKG5dpxEHS6CMqUVq1fP+
 VsDaMfaxbyZkAGCAMyKnmGyqkCW8ZBZEn061IQ8M6SRgEfYHs2uOhQPQj37hCW6LojlM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WIdaISNPqwn8Llsgc5HOxL21WdlzGWLzu2JU5+Qou48=; b=c3wPNH7kOd9ElsuXmmrinlB4xt
 O8EWnSudapN2NMSxGJHWPyJocNuCQjFZPDnSQ1bWcd3r5mTdWi+m1il7GVdUCJ8UOZT6R+Chpm80a
 gGlI8kxB+pjd3TJFPNiaS8XemQjknPRP19VdY0ccoQXoeZy1sbdJkFwAfuv5SvkCam1o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mELic-004hsQ-93
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 01:10:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0D9960E76;
 Fri, 13 Aug 2021 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628817036;
 bh=P7xrO+NWCshb+QKSx1kQ2DBMJrqKOnLzFvqQxOil/BE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Kl7TrLP/5h9CvllOQjZR9r6uVrWwfMKkvLxNHVgyOnqQ7TMn7HAYXWpH0gXqKjQFe
 ywBo783miVG5l7P1ZkEyl1B8HTTzcH9QAunKRNpMp91vdbzsB1hWzVxlN41SuWPplf
 R6ck2Ds1i6mba//CD7+SLuc/2FUlRkRobN/3vV+do3+aO7+a19FKbc+q9xzF4U1voz
 FSrShmg2DtEO0HUMgb37LTw+JovpffqtUcTe48wD6PjhldmMX2Mm0ww0UrTQbJ5/hH
 y8b6uN2k90fR9BjKatRfK01zmxFPZkgn1sB1HvFUKajlUBd9MxNCXfQdEetEckZmvJ
 bHBr82LmeyDnA==
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20210811044557.23951-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <6b198991-f092-0350-2257-87a25812b5a0@kernel.org>
Date: Fri, 13 Aug 2021 09:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811044557.23951-1-frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mELic-004hsQ-93
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: improve sbi status info in
 debugfs/f2fs/status
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

On 2021/8/11 12:45, Yangtao Li wrote:
> Do not use numbers but strings to improve readability when flag is set.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
