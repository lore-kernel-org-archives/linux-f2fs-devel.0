Return-Path: <SRS0=9J+C=XE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61819C00307
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:44:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C9220828
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GIcDyJrd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CuyX9tgd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wSKMB14H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C9220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i7ELl-0000Iu-Qh; Mon, 09 Sep 2019 07:44:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1i7ELl-0000Io-0y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Sep 2019 07:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PH79dTHp6aA/SSnxCOVsbK4lUreii9OgXT1x/h3R2MU=; b=GIcDyJrdbSZLCntrBp1TOEqMgD
 MXESezKGStF/4QZtipYAw1ktx8Lqu/FXkn/goURLILmyD4YpOkKuFsroD66wyq0WqLIjEY7DmXS+5
 Q5lVa39RabT/CtnvBX7trRXdfkBGgHzPDA3BkLhSz38Ducdl7Xxa8L9nUit/HHLk66GU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PH79dTHp6aA/SSnxCOVsbK4lUreii9OgXT1x/h3R2MU=; b=CuyX9tgdTVf2sa47CepRjnQP/w
 FFpvPkLr+SOynojH1rox+YL9UoIK+VVzZDeOZkwfhExdlf7xsVMLtkkEHhoTS1eA748XH8JISyYVx
 T/6PQH1eU8bTWWQqRjbUgyxriK0yVFtQQepOr8w5OZfXKZuCaMux6q0m6WGE95OWVApQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i7ELj-00FIsv-Py
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Sep 2019 07:44:36 +0000
Received: from localhost (unknown [148.69.85.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B5F1E20828;
 Mon,  9 Sep 2019 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568015070;
 bh=tV24GOjNAYTiVFG97hQg62EZuXRnUTpyN7sGlS4Bo40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wSKMB14HHy94yHAHJeWwQlxtq8Ja+zunbUz7s+CftQGOi42wdvZbRb682Q1hvFBym
 5jTYNBRHWG0ve3MFS92nykxMNmwwGA0ABKofpcAqyXyDCIcjjOx+7xPvJuK6t5vf9B
 vkHHwhh6Y/GWlW/l3ffOWSQSFgY1y6p7AAdRpA+w=
Date: Mon, 9 Sep 2019 08:44:25 +0100
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <20190909074425.GB21625@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190906105426.109151-1-yuchao0@huawei.com>
 <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
 <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1i7ELj-00FIsv-Py
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid accessing uninitialized
 field of inode page in is_alive()
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

On 09/07, Chao Yu wrote:
> On 2019-9-7 7:48, Jaegeuk Kim wrote:
> > On 09/06, Chao Yu wrote:
> >> If inode is newly created, inode page may not synchronize with inode cache,
> >> so fields like .i_inline or .i_extra_isize could be wrong, in below call
> >> path, we may access such wrong fields, result in failing to migrate valid
> >> target block.
> > 
> > If data is valid, how can we get new inode page?

Let me rephrase the question. If inode is newly created, is this data block
really valid to move in GC?

> 
> is_alive()
> {
> ...
> 	node_page = f2fs_get_node_page(sbi, nid);  <--- inode page

Aren't we seeing the below version warnings?

if (sum->version != dni->version) {
	f2fs_warn(sbi, "%s: valid data with mismatched node version.",
                           __func__);
        set_sbi_flag(sbi, SBI_NEED_FSCK);
}

> 
> 	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);

So, we're getting this? Does this incur infinite loop in GC?

if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
	f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
	f2fs_bug_on(sbi, 1);
}

> ...
> }
> 
> datablock_addr()
> {
> ...
> 	base = offset_in_addr(&raw_node->i);  <--- the base could be wrong here due to
> accessing uninitialized .i_inline of raw_node->i.
> ...
> }
> 
> Thanks,
> 
> > 
> >>
> >> - gc_data_segment
> >>  - is_alive
> >>   - datablock_addr
> >>    - offset_in_addr
> >>
> >> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/dir.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >> index 765f13354d3f..b1840852967e 100644
> >> --- a/fs/f2fs/dir.c
> >> +++ b/fs/f2fs/dir.c
> >> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
> >>  		if (IS_ERR(page))
> >>  			return page;
> >>  
> >> +		/* synchronize inode page's data from inode cache */
> >> +		f2fs_update_inode(inode, page);
> >> +
> >>  		if (S_ISDIR(inode->i_mode)) {
> >>  			/* in order to handle error case */
> >>  			get_page(page);
> >> -- 
> >> 2.18.0.rc1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
