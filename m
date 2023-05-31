Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8CBC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 May 2023 01:07:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4AJZ-00084b-Tf;
	Wed, 31 May 2023 01:07:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q4AJY-00084V-Ih
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 01:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GrPT/uQv6X5K5cj04GsbvD+ZJjCN17IH+4ImZg69FyE=; b=WGaO1jBcbPQvTNqxi+B8IbQqv+
 0igl283jdPOKoUPStJUJvVJjj1x88lxd2GDiWKgG0G5tdn9MXRYViiJOhY9AX/6hjKTypJgJEZlZF
 7Yc7U852fv3OStVSMzVmaE9oYM+esQuJsLDa3jeY8U/1KePhxmO9wPGBpoOQpV260YKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GrPT/uQv6X5K5cj04GsbvD+ZJjCN17IH+4ImZg69FyE=; b=f+TuDkZSsNMd0kueBwKISpRRPz
 JWNmnJXAcAr6tl+/ereF3bdaH05YPAGcHuGbrlCNN546hAiAOkludTPF62BtZ/ss898p3L2ozWtyy
 fO7GaRTBmq4DmIoUW3E/PYL6nZ7Gh/eayR6OP9T6T/XO1wgbJs9L7u+8RSP7k5DWgQic=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4AJU-0002j8-K2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 01:07:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 24ADE635BA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 31 May 2023 01:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCEBC433EF;
 Wed, 31 May 2023 01:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685495258;
 bh=cCsPHOFguQCfbgGXdjO4gjH/SPCEs9csIvcQwA4f8WI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IueK0c6n8ECNsv7hlhY8hIvw5n3oUt2VebU4NF5m99HHdjqy932Fd3W+WeFwO+9+3
 okbdpGlkD8qE/uJj2UDbxf1cVJXDimyJCuyitCgE1mVDTBZEQfQV4AWTSwHUy0O9X+
 LQHIdq6awkF8w8rFlPCARsjBGhIV1suiKxerkko5ZIzJQGJy4Yn2ANJQhN0Slw+jAv
 KaEWWzrUuAQxc3XIq5K3iJ4GLV2CJjcGHMS5cV0DwIqst0qtMVRyqLvYLnHOlSviPO
 zrrGkgwHFOuVvGKK06Apt3Dx2VGxgKpbnszt9HfCt/ia8+qEHI68ibNNFJ5Zekg57K
 VgXIT8x2DgL7A==
Message-ID: <c2c96d6f-f242-62be-1f92-5770dc8028f9@kernel.org>
Date: Wed, 31 May 2023 09:07:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230528080709.1692640-1-chao@kernel.org>
 <ZHZ/psv3hNbP0UBK@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZHZ/psv3hNbP0UBK@google.com>
X-Headers-End: 1q4AJU-0002j8-K2
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: clean up codes with IS_INODE()
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

On 2023/5/31 6:58, Jaegeuk Kim wrote:
> On 05/28, Chao Yu wrote:
>> and use le32_to_cpu() in IS_INODE().
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fsck/fsck.c  | 7 +++----
>>   fsck/mount.c | 4 ++--
>>   fsck/node.h  | 3 ++-
>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index e6ad71d..a4db2a3 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -247,7 +247,7 @@ static int is_valid_summary(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   		goto out;
>>   
>>   	/* check its block address */
>> -	if (node_blk->footer.nid == node_blk->footer.ino) {
>> +	if (IS_INODE(node_blk)) {
>>   		int ofs = get_extra_isize(node_blk);
>>   
>>   		if (ofs + ofs_in_node >= DEF_ADDRS_PER_INODE)
>> @@ -447,8 +447,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>>   				nid, ni->ino, le32_to_cpu(node_blk->footer.ino));
>>   		return -EINVAL;
>>   	}
>> -	if (ntype != TYPE_INODE &&
>> -			node_blk->footer.nid == node_blk->footer.ino) {
>> +	if (ntype != TYPE_INODE && IS_INODE(node_blk)) {
>>   		ASSERT_MSG("nid[0x%x] footer.nid[0x%x] footer.ino[0x%x]",
>>   				nid, le32_to_cpu(node_blk->footer.nid),
>>   				le32_to_cpu(node_blk->footer.ino));
>> @@ -3080,7 +3079,7 @@ static int fsck_reconnect_file(struct f2fs_sb_info *sbi)
>>   			ASSERT(err >= 0);
>>   
>>   			/* reconnection will restore these nodes if needed */
>> -			if (node->footer.ino != node->footer.nid) {
>> +			if (!IS_INODE(node)) {
>>   				DBG(1, "Not support non-inode node [0x%x]\n",
>>   				    nid);
>>   				continue;
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index f1fb525..90ecabf 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -2394,7 +2394,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
>>   	ASSERT(ret >= 0);
>>   
>>   	/* check its block address */
>> -	if (node_blk->footer.nid == node_blk->footer.ino) {
>> +	if (IS_INODE(node_blk)) {
>>   		int ofs = get_extra_isize(node_blk);
>>   
>>   		oldaddr = le32_to_cpu(node_blk->i.i_addr[ofs + ofs_in_node]);
>> @@ -2409,7 +2409,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
>>   	}
>>   
>>   	/* check extent cache entry */
>> -	if (node_blk->footer.nid != node_blk->footer.ino) {
>> +	if (!IS_INODE(node_blk)) {
>>   		get_node_info(sbi, le32_to_cpu(node_blk->footer.ino), &ni);
>>   
>>   		/* read inode block */
>> diff --git a/fsck/node.h b/fsck/node.h
>> index 99139b1..2ba7b8c 100644
>> --- a/fsck/node.h
>> +++ b/fsck/node.h
>> @@ -20,7 +20,8 @@
>>   
>>   static inline int IS_INODE(struct f2fs_node *node)
> 
> return bool?

Will change return value of IS_INODE.

> 
>>   {
>> -	return ((node)->footer.nid == (node)->footer.ino);
>> +	return le32_to_cpu(node->footer.ino) ==
>> +			le32_to_cpu(node->footer.nid);
> 
> Again, why do we need this conversion which looks uncessary?

Let me remove this in v2.

Thanks,

> 
>>   }
>>   
>>   static inline unsigned int ADDRS_PER_PAGE(struct f2fs_sb_info *sbi,
>> -- 
>> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
