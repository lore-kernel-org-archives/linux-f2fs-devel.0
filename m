From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v3] f2fs: add cur_reserved_blocks to support soft block
 reservation
Date: Thu, 26 Oct 2017 11:30:41 +0800
Message-ID: <3f0d83f5-f348-98a3-643f-169a4f9e23d6@huawei.com>
References: <1502199825-15218-1-git-send-email-yunlong.song@huawei.com>
 <1503068943-162538-1-git-send-email-yunlong.song@huawei.com>
 <fee3ad76-a490-3d3c-3699-a2f48759f8ef@huawei.com>
 <1748ac88-3415-0431-33e7-91cd1cff946c@kernel.org>
 <df73ab00-a313-a283-6512-1170c0c2fe3e@huawei.com>
 <04ef9339-940e-064a-f6cf-75671c956c04@kernel.org>
 <1d34c464-ca60-7380-13a1-1fd4d196dfb6@huawei.com>
 <0f20e316-166d-e5d2-30aa-1a406bdf7f85@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <0f20e316-166d-e5d2-30aa-1a406bdf7f85@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Agree

On 2017/10/26 11:26, Chao Yu wrote:
> On 2017/10/26 11:07, Yunlong Song wrote:
>> Yes, I agree with the soft semantic you introduce, it is too slow to
>> increase cur_reserved_blocks only in
>> dec_valid_block(,node)_count, e.g. if users want to set
>> cur_reserved_blocks to 10G.
> Yup,
>
>> Then how about fix the initialization of cur_reserved_blocks in
>> fs/f2fs/super.c as following:
>> sbi->current_reserved_blocks = 0
>> change to
>> sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>> sbi->user_block_count - valid_user_blocks(sbi));
> It will be necessary only if reserved_blocks is initialized with a non-zero value,
> but now it has value of zero, so it's redundant...
>
> What about adding this check if we initialize reserved_blocks with a non-zero default
> value or value which may be configured with mount_option?
>
> Thanks,
>
>> On 2017/10/25 23:46, Chao Yu wrote:
>>> On 2017/10/25 22:06, Yunlong Song wrote:
>>>> Hi, Chao,
>>>>       Please see my comments below.
>>>>
>>>> On 2017/10/25 20:26, Chao Yu wrote:
>>>>> On 2017/10/25 18:02, Yunlong Song wrote:
>>>>>> ping...
>>>>> I've replied in this thread, check your email list please, or you can check the
>>>>> comments in below link:
>>>>>
>>>>> https://patchwork.kernel.org/patch/9909407/
>>>>>
>>>>> Anyway, see comments below.
>>>>>
>>>>>> On 2017/8/18 23:09, Yunlong Song wrote:
>>>>>>> This patch adds cur_reserved_blocks to extend reserved_blocks sysfs
>>>>>>> interface to be soft threshold, which allows user configure it exceeding
>>>>>>> current available user space. To ensure there is enough space for
>>>>>>> supporting system's activation, this patch does not set the reserved space
>>>>>>> to the configured reserved_blocks value at once, instead, it safely
>>>>>>> increase cur_reserved_blocks in dev_valid_block(,node)_count to only take
>>>>>>> up the blocks which are just obsoleted.
>>>>>>>
>>>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>> ---
>>>>>>>      Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
>>>>>>>      fs/f2fs/f2fs.h                          | 13 +++++++++++--
>>>>>>>      fs/f2fs/super.c                         |  3 ++-
>>>>>>>      fs/f2fs/sysfs.c                         | 15 +++++++++++++--
>>>>>>>      4 files changed, 28 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>>>> index 11b7f4e..ba282ca 100644
>>>>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>>>> @@ -138,7 +138,8 @@ What:        /sys/fs/f2fs/<disk>/reserved_blocks
>>>>>>>      Date:        June 2017
>>>>>>>      Contact:    "Chao Yu" <yuchao0@huawei.com>
>>>>>>>      Description:
>>>>>>> -         Controls current reserved blocks in system.
>>>>>>> +         Controls current reserved blocks in system, the threshold
>>>>>>> +         is soft, it could exceed current available user space.
>>>>>>>        What:        /sys/fs/f2fs/<disk>/gc_urgent
>>>>>>>      Date:        August 2017
>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>> index 2f20b6b..84ccbdc 100644
>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>> @@ -1041,6 +1041,7 @@ struct f2fs_sb_info {
>>>>>>>          block_t discard_blks;            /* discard command candidats */
>>>>>>>          block_t last_valid_block_count;        /* for recovery */
>>>>>>>          block_t reserved_blocks;        /* configurable reserved blocks */
>>>>>>> +    block_t cur_reserved_blocks;        /* current reserved blocks */
>>>>>>>            u32 s_next_generation;            /* for NFS support */
>>>>>>>      @@ -1515,7 +1516,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>>>>>>            spin_lock(&sbi->stat_lock);
>>>>>>>          sbi->total_valid_block_count += (block_t)(*count);
>>>>>>> -    avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
>>>>>>> +    avail_user_block_count = sbi->user_block_count -
>>>>>>> +                        sbi->cur_reserved_blocks;
>>>>>>>          if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>>>>>>>              diff = sbi->total_valid_block_count - avail_user_block_count;
>>>>>>>              *count -= diff;
>>>>>>> @@ -1549,6 +1551,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>>>>>>>          f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
>>>>>>>          f2fs_bug_on(sbi, inode->i_blocks < sectors);
>>>>>>>          sbi->total_valid_block_count -= (block_t)count;
>>>>>>> +    if (sbi->reserved_blocks &&
>>>>>>> +        sbi->reserved_blocks != sbi->cur_reserved_blocks)
>>>>> It's redundent check here...
>>>> I think in most cases, cur_reserved_blocks is equal to reserved_blocks, so we do not need to calculate min any more, otherwise,
>>>> if reserved_blocks is not 0, it will calculate min and set current_reserved_blocks each time.
>>> OK, IMO, in some condition, we can save dirtying cache line to decrease cache
>>> line missing with that check.
>>>
>>>>>>> +        sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
>>>>>>> +                    sbi->cur_reserved_blocks + count);
>>>>>>>          spin_unlock(&sbi->stat_lock);
>>>>>>>          f2fs_i_blocks_write(inode, count, false, true);
>>>>>>>      }
>>>>>>> @@ -1695,7 +1701,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>>>>>>          spin_lock(&sbi->stat_lock);
>>>>>>>            valid_block_count = sbi->total_valid_block_count + 1;
>>>>>>> -    if (unlikely(valid_block_count + sbi->reserved_blocks >
>>>>>>> +    if (unlikely(valid_block_count + sbi->cur_reserved_blocks >
>>>>>>>                              sbi->user_block_count)) {
>>>>>>>              spin_unlock(&sbi->stat_lock);
>>>>>>>              goto enospc;
>>>>>>> @@ -1738,6 +1744,9 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
>>>>>>>            sbi->total_valid_node_count--;
>>>>>>>          sbi->total_valid_block_count--;
>>>>>>> +    if (sbi->reserved_blocks &&
>>>>>>> +        sbi->reserved_blocks != sbi->cur_reserved_blocks)
>>>>> Checking low boundary is more safe here.
>>>> I think cur_reserved_blocks can never be larger than reserved_blocks in any case. so min(reserved_blocks,
>>>> cur_reserved_blocks +1) is same to cur_reserved_blocks++ when reserved_blocks != cur_reserved_blocks
>>>> (which means reserved_blocks > cur_reserved_block )
>>> Ditto.
>>>
>>>>>>> +        sbi->cur_reserved_blocks++;
>>>>>>>            spin_unlock(&sbi->stat_lock);
>>>>>>>      diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>>> index 4c1bdcb..16a805f 100644
>>>>>>> --- a/fs/f2fs/super.c
>>>>>>> +++ b/fs/f2fs/super.c
>>>>>>> @@ -957,7 +957,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>>>>>          buf->f_blocks = total_count - start_count;
>>>>>>>          buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>>>>>>>          buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>>>>>>> -                        sbi->reserved_blocks;
>>>>>>> +                        sbi->cur_reserved_blocks;
>>>>>>>            avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>>>>>>>      @@ -2411,6 +2411,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>                      le64_to_cpu(sbi->ckpt->valid_block_count);
>>>>>>>          sbi->last_valid_block_count = sbi->total_valid_block_count;
>>>>>>>          sbi->reserved_blocks = 0;
>>>>>>> +    sbi->cur_reserved_blocks = 0;
>>>>>>>            for (i = 0; i < NR_INODE_TYPE; i++) {
>>>>>>>              INIT_LIST_HEAD(&sbi->inode_list[i]);
>>>>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>>>>> index a1be5ac..75c37bb 100644
>>>>>>> --- a/fs/f2fs/sysfs.c
>>>>>>> +++ b/fs/f2fs/sysfs.c
>>>>>>> @@ -104,12 +104,22 @@ static ssize_t features_show(struct f2fs_attr *a,
>>>>>>>          return len;
>>>>>>>      }
>>>>>>>      +static ssize_t f2fs_reserved_blocks_show(struct f2fs_attr *a,
>>>>>>> +        struct f2fs_sb_info *sbi, char *buf)
>>>>>>> +{
>>>>>>> +    return snprintf(buf, PAGE_SIZE, "expected: %u\ncurrent: %u\n",
>>>>>>> +            sbi->reserved_blocks, sbi->cur_reserved_blocks);
>>>>>>> +}
>>>>>>> +
>>>>>>>      static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>>>>>>                  struct f2fs_sb_info *sbi, char *buf)
>>>>>>>      {
>>>>>>>          unsigned char *ptr = NULL;
>>>>>>>          unsigned int *ui;
>>>>>>>      +    if (a->struct_type == RESERVED_BLOCKS)
>>>>>>> +        return f2fs_reserved_blocks_show(a, sbi, buf);
>>>>>>> +
>>>>>>>          ptr = __struct_ptr(sbi, a->struct_type);
>>>>>>>          if (!ptr)
>>>>>>>              return -EINVAL;
>>>>>>> @@ -143,12 +153,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>>>>>>      #endif
>>>>>>>          if (a->struct_type == RESERVED_BLOCKS) {
>>>>>>>              spin_lock(&sbi->stat_lock);
>>>>>>> -        if ((unsigned long)sbi->total_valid_block_count + t >
>>>>>>> -                (unsigned long)sbi->user_block_count) {
>>>>>>> +        if (t > (unsigned long)sbi->user_block_count) {
>>>>>>>                  spin_unlock(&sbi->stat_lock);
>>>>>>>                  return -EINVAL;
>>>>>>>              }
>>>>>>>              *ui = t;
>>>>>>> +        if (t < (unsigned long)sbi->cur_reserved_blocks)
>>>>>>> +            sbi->cur_reserved_blocks = t;
>>>>> No, for 't < cur_reserved_blocks' case, cur_reserved_blocks will out of update
>>>>> even if there is enough free space. You know, for soft block resevation, we need
>>>>> to reserve blocks as many as possible, making free space being zero suddenly is
>>>>> possible.
>>>> I do not understand why it is not safe to decrease cur_reserved_blocks, for example,
>>>> if current cur_reserved_blocks is 100, now decrease it to 80, is there any problem?
>>>> If 80 will make free space zero, how does 100 exist?
>>>> And I do not think it is safe as following:
>>>>            *ui = t;
>>>> +        sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>>>> +                sbi->user_block_count - valid_user_blocks(sbi));
>>>>
>>>> If user_block_count = 200, valid_user_blocks=150， reserved_blocks = 100,
>>>> then current_reserved_block = min(100,200-50) = 50, in this case, free space
>>>> is suddenly becoming zero.
>>> Free space becomes zero suddenly is safe, as I said before, I don't expect this
>>> feature can be used in android, instead, it may be used in distributed storage
>>> scenario, in where, once we configure soft_reserved_block making one server out
>>> of free space, it's not critical issue to this system since we can move current
>>> copy to another server which has enough free space.
>>>
>>> Secondly, as an global configuration, it's due to usage of administrator with
>>> it, if there is critical application which is sensitive with free space,
>>> administrator should make sure our reservation should not overload consuming free
>>> space, which means soft reservation is not suitable.
>>>
>>>> To avoid this, I change the code to:
>>>>
>>>> +        if (t < (unsigned long)sbi->cur_reserved_blocks)
>>>> +            sbi->cur_reserved_blocks = t;
>>>>
>>>> I think it is only safe to decrease the value of cur_reserved_blocks, and leave increase operation to
>>>> dec_valid_block(,node)_count, it is safe to increase cur_reserved_blocks there.
>>> For initialization of reserved_blocks, cur_reserved_blocks will always be zero
>>> due to this check, and will be updated to close to reserved_blocks after block
>>> allocation and deallocation of user, IMO, it's not looks reasonable to user.
>>>
>>> Anyway, it's due to how you define semantics of soft reservation, so what is your
>>> understanding of it?
>>>
>>> Thanks,
>>>
>>>>> Thanks,
>>>>>
>>>>>>>              spin_unlock(&sbi->stat_lock);
>>>>>>>              return count;
>>>>>>>          }
>>>>> .
>>>>>
>>> .
>>>
>
> .
>

-- 
Thanks,
Yunlong Song
