From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] fsck.f2fs: check validity of nat journal
Date: Wed, 23 Jan 2019 10:02:12 +0800
Message-ID: <48d2573a-c14a-87fc-2cdc-7164c374a69f@huawei.com>
References: <20190114013308.80535-1-yuchao0@huawei.com>
 <20190122235953.GA44459@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gm7s0-00081a-Hp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 02:02:24 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gm7ry-006ekX-GM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 02:02:24 +0000
In-Reply-To: <20190122235953.GA44459@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/1/23 7:59, Jaegeuk Kim wrote:
> On 01/14, Chao Yu wrote:
>> As reported by Aravind:
>>
>> I built f2fs tools from source (at tag v1.12.0) and was able to get this backtrace in gdb:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff7f8eb54 in f2fs_set_bit (nr=1041170432,
>>     addr=0x7fffff621010 <error: Cannot access memory at address 0x7fffff621010>) at libf2fs.c:312
>> 312        mask = 1 << (7 - (nr & 0x07));
>> (gdb) where
>>     addr=0x7fffff621010 <error: Cannot access memory at address 0x7fffff621010>) at libf2fs.c:312
>>
>>> [ 5338.040024] nats:8781, sits:6
>>> [ 5338.040027] F2FS-fs (sda2): Failed to initialize F2FS segment manager
>>> [ 5338.128893] nats:8781, sits:6
>>> [ 5338.128895] F2FS-fs (sda2): Failed to initialize F2FS segment manager
>>
>> nat_count/nid/blkaddr recorded in journal may be corrupted, let's do
>> sanity check on them, skip loading invalid ones during build_node_manager().
> 
> This requires the below diff.
> 
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -376,6 +376,9 @@ static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
> 
>  static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
>  {
> +       if (addr == NULL_ADDR || addr == NEW_ADDR)
> +               return 1;

Actually, IS_VALID_BLK_ADDR() is used in many places, after the check, we
may load data from position pointed with @addr, so, we may not return true
if addr is equal to NULL_ADDR/NEW_ADDR.

Thanks,

> +
>         if (addr >= le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count) ||
>                                 addr < SM_I(sbi)->main_blkaddr) {
>                 DBG(1, "block addr [0x%x]\n", addr);
> 
>>
>> Reported-by: Aravind R S <aravindet@gmail.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3:
>> - truncate nat journal table once any journalled nat entry is corrupted
>>  fsck/mount.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index 3966525104a7..51d0a09695eb 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -1066,11 +1066,29 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
>>  			f2fs_set_bit(nid, nm_i->nid_bitmap);
>>  	}
>>  
>> +	if (nats_in_cursum(journal) > NAT_JOURNAL_ENTRIES) {
>> +		MSG(0, "\tError: f2fs_init_nid_bitmap truncate n_nats(%u) to "
>> +			"NAT_JOURNAL_ENTRIES(%lu)\n",
>> +			nats_in_cursum(journal), NAT_JOURNAL_ENTRIES);
>> +		journal->n_nats = cpu_to_le16(NAT_JOURNAL_ENTRIES);
>> +	}
>> +
>>  	for (i = 0; i < nats_in_cursum(journal); i++) {
>>  		block_t addr;
>>  
>>  		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
>> +		if (!IS_VALID_BLK_ADDR(sbi, addr)) {
>> +			MSG(0, "\tError: f2fs_init_nid_bitmap: addr(%u) is invalid!!!\n", addr);
>> +			journal->n_nats = cpu_to_le16(i);
>> +			continue;
>> +		}
>> +
>>  		nid = le32_to_cpu(nid_in_journal(journal, i));
>> +		if (!IS_VALID_NID(sbi, nid)) {
>> +			MSG(0, "\tError: f2fs_init_nid_bitmap: nid(%u) is invalid!!!\n", nid);
>> +			journal->n_nats = cpu_to_le16(i);
>> +			continue;
>> +		}
>>  		if (addr != NULL_ADDR)
>>  			f2fs_set_bit(nid, nm_i->nid_bitmap);
>>  	}
>> -- 
>> 2.18.0.rc1
> 
> .
> 
