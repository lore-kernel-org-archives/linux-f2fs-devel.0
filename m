From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v6] f2fs: support in-memory inode checksum
 when checking consistency
Date: Sun, 15 Jul 2018 14:38:14 +0800
Message-ID: <2dc827b6-d8a6-b12f-edfe-c34df262df91@kernel.org>
References: <20180309151021.142737-1-guoweichao@huawei.com>
 <4a425d34-125d-24a8-83e6-9531d8174de4@kernel.org>
 <b1c343b0-671e-283d-9f8c-9ac5005a13ff@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1feafx-0002mQ-7U
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 06:38:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1feafv-009cNK-R7
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 06:38:33 +0000
In-Reply-To: <b1c343b0-671e-283d-9f8c-9ac5005a13ff@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Weichao and Jaegeuk,

On 2018/6/22 15:16, Chao Yu wrote:
> On 2018/6/12 22:36, Chao Yu wrote:
>> Ping,
>>
>> Jaegeuk, sometimes, we suffer data corruption caused by bit-transition of cache,
>> we troubleshoot for weeks or months, and finally, find that it is caused by
>> hardware. So for this case, maybe in-memory checksum can help to troubleshoot
>> more quickly.

I encounter mismatch on checksum when I test generic/475, I think we should add
missing calculation in below place:

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index b0da4c2..0f4db7a 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -449,6 +449,10 @@ static inline void set_mark(struct page *page, int mark,
int type)
 	else
 		flag &= ~(0x1 << type);
 	rn->footer.flag = cpu_to_le32(flag);
+
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_P_SB(page), page);
+#endif
 }
 #define set_dentry_mark(page, mark)	set_mark(page, mark, DENT_BIT_SHIFT)
 #define set_fsync_mark(page, mark)	set_mark(page, mark, FSYNC_BIT_SHIFT)

>>
>> Could you consider this?
>>
>> Thanks,
>>
>> On 2018/3/9 23:10, Weichao Guo wrote:
>>> Enable in-memory inode checksum to protect metadata blocks from
>>> in-memory scribbles when checking consistency, which has no
>>> performance requirements.
>>>
>>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
