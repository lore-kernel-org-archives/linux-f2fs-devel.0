From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH] f2fs: direct I/O -> buffered I/O for
 FI_NO_PREALLOC & FI_INLINE_DATA
Date: Fri, 29 Sep 2017 13:51:15 +0800
Message-ID: <56e09fb5-6dc8-c712-e8c8-e0a6e60c1ec8@huawei.com>
References: <20170928214729.144483-1-guoweichao@huawei.com>
 <8802c6e5-2e60-12a1-5792-2782d8310d77@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <guoweichao@huawei.com>)
 id 1dxoDa-00054w-Nt
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Sep 2017 05:52:10 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dxoDS-0004yG-Nt
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Sep 2017 05:52:10 +0000
In-Reply-To: <8802c6e5-2e60-12a1-5792-2782d8310d77@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Sure, I will prepare another patch to fix this case.

On 2017/9/28 22:23, Chao Yu wrote:
> On 2017/9/29 5:47, guoweichao@huawei.com wrote:
>> From: Weichao Guo <guoweichao@huawei.com>
>>
>> In FI_NO_PREALLOC cases, direct I/O path may allocate blocks for an inode but
>> keep its inline data flag. This inconsistency may trigger vfs clear_inode
>> nrpages bug_on when evicting the inode. Let buffered I/O handle this case.
> 
> Good catch!
> 
> Could we just convert inline data by force in f2fs_preallocate_blocks for this
> case? it can avoid write fallback from direct IO to buffered IO.
> 
> Thanks,
> 
> 
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> ---
>>  fs/f2fs/data.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 36b5352..039f6d8 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -822,7 +822,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>>  
>>  static inline bool __force_buffered_io(struct inode *inode, int rw)
>>  {
>> -	return (f2fs_encrypted_file(inode) ||
>> +	return (f2fs_encrypted_file(inode) || f2fs_has_inline_data(inode) ||
>>  			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
>>  			F2FS_I_SB(inode)->s_ndevs);
>>  }
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
