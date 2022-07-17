Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69016C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 03:37:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCv6N-0003Ag-55; Sun, 17 Jul 2022 03:37:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oCv6L-0003AS-BW
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 03:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZTFNDnKrai3jK8KQHazHGiHBuqZwe6HD30qPXHguMQk=; b=F8ERwRzuEBFBYD/dP6aGBYI51H
 Aoedou6YzBYGjIkMe8hS0o3t663VUhG176JNr63C9graERpZI6v66hNBsurt6j0IJGjLTIk1iFFm/
 Ofdmtnp8V+fs4R0Xp4wckm57mnKQgKEnO1q2NMi4vSjTIY22ooSD+zCVEuo22NlliLOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZTFNDnKrai3jK8KQHazHGiHBuqZwe6HD30qPXHguMQk=; b=KckdJXOMt7PusnnRQGhIgXgRy6
 DfG2fpGIbP7uCRimPb60zIAc28PXItkXNgwASsUVEvRrcxDCCLEsZZR0RImst5s69QtE23GIUHvXZ
 Ji73moac3gw4FvI2uazwLqOjeiPmRzji9ifxXWqahpThnUoeSJcb1/zr/dBLMooGn8lE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oCv6G-001XAm-NW
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 03:37:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5841560F8D;
 Sun, 17 Jul 2022 03:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC424C3411E;
 Sun, 17 Jul 2022 03:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658029058;
 bh=pRIWF3RbvpGBU+NBKLS7yBuX3WRUaO5aXilcEQeOxfI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aPpj0AVqaMuQ14f/C0CFwwY6JiaG/WR6x1gPYpuidJzbxtBHgFlWty/d65DuOjP4Y
 BWicTCELGZhf8x81cyCDmf+RAV2gZhgkRctJE2mvh/FUJfk61tt1nMzO9NitxaAHdz
 etbyjYWlGrJRfa2talX1fNNgB9N/LIDLe7ogEDTe5jRQOqjbn0WKUnKXOGP0I0cVTU
 RQmHV3sXAMhzCPQswRHxcxpwKhfwfHuBptT6xirFc1KkAbOtLcFJgu3ZKdbCOdykoC
 h/JCmFjHNTupAFcyajQgqBdQ9hH5TytF1n78B1T1S1LMf5Oxtcp/RqeWu6ZlG53w73
 cX/SihXvXhlyw==
Message-ID: <f0c4af4f-e624-1b70-7640-689df98b4f66@kernel.org>
Date: Sun, 17 Jul 2022 11:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220623181208.3596448-1-bvanassche@acm.org>
 <20220623181208.3596448-5-bvanassche@acm.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220623181208.3596448-5-bvanassche@acm.org>
X-Headers-End: 1oCv6G-001XAm-NW
Subject: Re: [f2fs-dev] [PATCH v2 4/5] Use F2FS_BLKSIZE for dev_read_block()
 buffers
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/24 2:12, Bart Van Assche wrote:
> Use F2FS_BLKSIZE instead of PAGE_SIZE for dev_read_block() buffers since
> dev_read_block() reads F2FS_BLKSIZE bytes.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
