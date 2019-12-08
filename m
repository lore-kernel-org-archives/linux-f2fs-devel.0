Return-Path: <SRS0=gtlW=Z6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82316C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  8 Dec 2019 04:03:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C82206D6;
	Sun,  8 Dec 2019 04:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WwvCon0l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Odqd2Qxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C82206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1idnmf-00009T-QM; Sun, 08 Dec 2019 04:03:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1idnmc-00009A-Vj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Dec 2019 04:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lSP8/e8OjiSNZZDmK6SxArGfSuSlNA5shfAilc1iQA0=; b=WwvCon0lfSQ+LtFM1vJLLC91X
 S3y+f4hpHc21qvHf1YP2q/Btsa6KKPBgutAJFui4akhVfB5Gl2I45IH0LP7SK4fM9zu9QLGHSwEM2
 J9f0zl/1XO+pqDzEMuHMdwrdr6yO7KrfgPF53EHvji/4f0Gxw3RK2IiQBRWfXV4gucYRk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lSP8/e8OjiSNZZDmK6SxArGfSuSlNA5shfAilc1iQA0=; b=Odqd2Qxdb8p/1AVvWMXXQGh9jr
 G33jBw9eh/uzT0XqnMOqTBrswnPFShSc/EpaG2bk07sGRIOoUVElkVg3+Cr4lgYRyWly6DmFCJQ8P
 B5Cvb0HTcjTClg5U2rBzWLJiTbqdRzAyYDWzKDrrRws1ZK3IwGVnbsTJbRfDDFwWfmko=;
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1idnmb-00Dg7k-9W
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Dec 2019 04:02:58 +0000
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1idnS4-00084W-CV; Sun, 08 Dec 2019 03:41:47 +0000
Date: Sun, 8 Dec 2019 03:41:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20191208034144.GP4203@ZenIV.linux.org.uk>
References: <1575718548-19017-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1575718548-19017-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Headers-End: 1idnmb-00Dg7k-9W
Subject: Re: [f2fs-dev] [PATCH v3] fs: introduce is_dot_dotdot helper for
 cleanup
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
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Dec 07, 2019 at 07:35:48PM +0800, Tiezhu Yang wrote:
> There exists many similar and duplicate codes to check "." and "..",
> so introduce is_dot_dotdot helper to make the code more clean.

Umm...  No objections, in principle, but... you try to say that name
(e.g. in a phone conversation) without stuttering ;-/

Any suggestions from native speakers?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
