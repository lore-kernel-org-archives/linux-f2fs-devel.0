Return-Path: <SRS0=FIBF=NP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD17BC19F33
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:09:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5E1613D5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D5E1613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mIZvx-0000tS-3t; Tue, 24 Aug 2021 17:09:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mIZvv-0000t8-R4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 17:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V2MTz9cQbW6iOz9s5K63TnyC6Zgxqq4IL2SaMXC9LcI=; b=UAyAeiQKjvZ6f9ZQSlGU+wK1eI
 87jpR5G1a0lDowjqYTV9NTlRDSQT9yW+Kwzm2DV9jYmxooWhhaFom1RPZfGP4WEHR7QSmyLMT4gS3
 Y7uCXCC0AcfX2zGPDlSoa++NFhSgdLKlsQTN8RN+b7AprsVf9KA8GihYFzKmOiUidsSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V2MTz9cQbW6iOz9s5K63TnyC6Zgxqq4IL2SaMXC9LcI=; b=csoUggRnUiApsh4DSzSOn3A7tX
 MaSGIVNQ8zEAhEX216D/CnQ+qftW4sRSTNfkHdXrBbwEyUMdq6wDW8veOZKiKFyyoajCWsH9p+CLx
 tx1R5q5jVhJvAZghi2oLotefPc638X0dVYrMXmkUr/+YvhlmHZZnuenkRaA3j75fy32g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mIZvu-00HA76-2v
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 17:09:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB4B613DB;
 Tue, 24 Aug 2021 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629824983;
 bh=k6/DyiNxY9iHMyx+vqOZpeLhFY0OrsTTDraIpNfySmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m6mudTayuZeB7SiPMQXlGDH/1inDLPr+v9d0hlxVFaVmSr3pb9tz574iWPfbBC7N2
 jA5Lsn9U3zT49DcTaRzhe3Vs+4/tQqI3b0DLFlfBHDYpfPjSu2UJLsx14S5yh+kPCb
 uTcmtS1OufW7MKSbzo4MpzjbVg1xwxjN55SWRdowLT1hi1lcjntZoNeUGHkYnkxhnL
 OiHmQrIOmx8BA5DlrI+ZJKHCv9pkrhueHI52J8sZueo4exQ5m9lFi9Jlb7awJfYL1r
 PZPYvuouE3yOGDwC0wGwDOY1pkIuXWHFeY+hoY4qjv9e7RHtaS44Ia0dRtxnxVpg7P
 HOEi52W+z4HkQ==
Date: Tue, 24 Aug 2021 10:09:42 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YSUn1j22s/kc+hWS@google.com>
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
X-Headers-End: 1mIZvu-00HA76-2v
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/24, Chao Yu wrote:
> On 2021/8/24 1:01, Jaegeuk Kim wrote:
> > We must flush dirty pages when calling fsync() during checkpoint=disable.
> > Returning zero makes inode being clear, which fails to flush them when
> > enabling checkpoint back even by sync_inodes_sb().
> 
> Without this patch, file can be persisted via checkpoint=enable as well, my
> testcase:
> 
> - mount -t f2fs -o checkpoint=disable,checkpoint_nomerge /dev/pmem0 /mnt/f2fs/
> - cp file /mnt/f2fs/
> - xfs_io /mnt/f2fs/file -c "fdatasync"
> - mount -o remount,checkpoint=enable /dev/pmem0 /mnt/f2fs/
> - umount /mnt/f2fs
> - mount /dev/pmem0 /mnt/f2fs
> - md5sum file /mnt/f2fs/file
> chksum values are the same.
> 
> Am I missing something?

I'm trying to address one subtle issue where a file has only NEW_ADDR by the
checkpoint=disable test. I don't think this hurts anything but can see
some mitigation of the issue.

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
